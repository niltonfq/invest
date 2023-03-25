package br.com.abs.invest.controllers;

import static io.restassured.RestAssured.given;
import static org.junit.Assert.assertNotNull;

import java.util.List;

import org.json.JSONObject;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.MethodOrderer.OrderAnnotation;
import org.junit.jupiter.api.Order;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.TestMethodOrder;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.jdbc.Sql;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.datatype.jsr310.JavaTimeModule;

import br.com.abs.invest.models.AtivoModel;
import io.restassured.builder.RequestSpecBuilder;
import io.restassured.filter.log.LogDetail;
import io.restassured.filter.log.RequestLoggingFilter;
import io.restassured.filter.log.ResponseLoggingFilter;
import io.restassured.specification.RequestSpecification;

@SpringBootTest(webEnvironment = SpringBootTest.WebEnvironment.DEFINED_PORT)
@TestMethodOrder(OrderAnnotation.class)
class AtivoControllerTest {

	private static RequestSpecification specification;
	private static ObjectMapper objectMapper;

	@BeforeAll
	public static void setup() {
		objectMapper = new ObjectMapper();
		objectMapper.registerModule(new JavaTimeModule());
		objectMapper.disable(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES);

	}

	@Test
	@Order(1)
	public void authorization() {

		specification = new RequestSpecBuilder()
				//.addHeader(TestConfigs.HEADER_PARAM_AUTHORIZATION, "Bearer " + token)
				.setPort(8888)
				.addFilter(new RequestLoggingFilter(LogDetail.ALL))
				.addFilter(new ResponseLoggingFilter(LogDetail.ALL))
				.build();
	}

	@Test
	@Order(2)
	public void getAtivosComUsuarioInexistenteRetornaNotFound() throws Exception {
		given().spec(specification).contentType("application/json")
				.basePath("/usuario/525c853f-dd20-4d1d-a1d7-59edd31b112f/ativos")
				.queryParams("page", 0, "limit", 5, "direction", "asc")
				.when().get()
				.then().statusCode(200);
		
	}
	
	@Test
	@Order(3)
	@Sql("/dados_de_teste.sql")
	public void getAtivosComUsuarioValidoRetornaAtivos() throws Exception {
		var content = given().spec(specification).contentType("application/json")
				.basePath("/usuario/7062c0e4-6e5d-4125-ad1c-7363cf72e45c/ativos")
				.queryParams("page", 0, "limit", 5, "direction", "asc")
				.when().get()
				.then().statusCode(200)
				.extract().body().asString();
		
		
		JSONObject jsonObject = new JSONObject(content);
		String resp = jsonObject.get("content").toString();
		
		List<AtivoModel> ativos = objectMapper.readValue(resp, new TypeReference<List<AtivoModel>>() {});
		
		AtivoModel ativo = ativos.get(0);
		
		assertNotNull(ativo.getId());
		
		
	}

}
