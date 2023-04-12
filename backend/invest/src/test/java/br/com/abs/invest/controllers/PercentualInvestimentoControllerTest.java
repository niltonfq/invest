package br.com.abs.invest.controllers;

import static io.restassured.RestAssured.given;
import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertTrue;

import java.util.List;

import org.json.JSONObject;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.MethodOrderer.OrderAnnotation;
import org.junit.jupiter.api.Order;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.TestMethodOrder;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.jdbc.Sql;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.datatype.jsr310.JavaTimeModule;

import br.com.abs.invest.dtos.PercentualInvestimentoDto;
import br.com.abs.invest.models.PercentualInvestimentoModel;
import io.restassured.builder.RequestSpecBuilder;
import io.restassured.filter.log.LogDetail;
import io.restassured.filter.log.RequestLoggingFilter;
import io.restassured.filter.log.ResponseLoggingFilter;
import io.restassured.specification.RequestSpecification;


@SpringBootTest(webEnvironment = SpringBootTest.WebEnvironment.DEFINED_PORT)
@TestMethodOrder(OrderAnnotation.class)
class PercentualInvestimentoControllerTest {

	final String MAIN_ID = "1124681c-0172-4a73-917b-22eab0093e03";
	private static RequestSpecification specification;
	private static ObjectMapper objectMapper;
	
	private static PercentualInvestimentoDto percentualInvestimentoDto;

	@BeforeAll
	public static void setup() {
		objectMapper = new ObjectMapper();
		objectMapper.registerModule(new JavaTimeModule());
		objectMapper.disable(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES);

		percentualInvestimentoDto = new PercentualInvestimentoDto();
	}

	@Test
	@Order(1)
	@Sql("/dados_de_teste.sql")
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
	public void getPercentualInvestimentosDadosInvalidosRetornaVazio() throws Exception {
		      given().spec(specification).contentType("application/json")
				.basePath("/usuario/525c953f-dd20-4d1d-a1d7-59edd31b112f/percentualInvestimentos")
				.queryParams("page", 0, "limit", 5, "direction", "asc")
				.when().get()
				.then().statusCode(404)
				.extract().body().asString();
	}
	
	@Test
	@Order(3)	
	public void getPercentualInvestimentosDadosValidosRetornaPercentualInvestimentos() throws Exception {
		var content = given().spec(specification).contentType("application/json")
				.basePath("/percentualInvestimentos/usuario/7062c0e4-6e5d-4125-ad1c-7363cf72e45c")
				.queryParams("page", 0, "limit", 5, "direction", "asc")
				.when().get()
				.then().statusCode(200)
				.extract().body().asString();
		
		
		JSONObject jsonObject = new JSONObject(content);
		String resp = jsonObject.get("content").toString();
		
		List<PercentualInvestimentoModel> percentualInvestimentos = objectMapper.readValue(resp, new TypeReference<List<PercentualInvestimentoModel>>() {});
		
		assertTrue(percentualInvestimentos.size() == 1);
		assertTrue(percentualInvestimentos.get(0).getAcoes() == 20);
		
	}

	@Test
	@Order(4)	
	public void getOnePercentualInvestimentoDadosValidoRetornaPercentualInvestimento() throws Exception {
		var content = given().spec(specification).contentType("application/json")
				.basePath("/percentualInvestimentos/"+MAIN_ID+"/usuario/7062c0e4-6e5d-4125-ad1c-7363cf72e45c")
					.when().get()
				.then()
					.statusCode(200)
				.extract().body().asString();
		
		
		PercentualInvestimentoModel percentualInvestimento = objectMapper.readValue(content, PercentualInvestimentoModel.class);
		    
		assertNotNull(percentualInvestimento.getId());
		assertNotNull(percentualInvestimento.getAcoes());
		

	}
	
	@Test
	@Order(5)	
	public void getOnePercentualInvestimentoDadosInvalidosRetornaNotFound() throws Exception {
		given().spec(specification).contentType("application/json")
				.basePath("/percentualInvestimentos/32380fb1-82aa-4766-b63e-0141f5df5207/usuario/7062c0e4-6e5d-4125-ad1c-7363cf72e45c")
					.when().get()
				.then()
					.statusCode(404)
				.extract().body().asString();
		
	}
	
	@Test
	@Order(6)
	public void postPercentualInvestimentoDadosValidosRetornaCriado() throws JsonMappingException, JsonProcessingException {
	    
		percentualInvestimentoDto.setRendaFixa((short)30);
		
	    var content = given().spec(specification)
	            .contentType("application/json")
	            .basePath("/percentualInvestimentos/usuario/72de1471-28e0-4f0b-9128-f4903787e2dc")
	                .body(percentualInvestimentoDto)
	                .when()
	                .post()
	            .then()
	                .statusCode(201)
	                    .extract()
	                    .body()
	                        .asString();
	    
	    PercentualInvestimentoModel percentualInvestimento = objectMapper.readValue(content, PercentualInvestimentoModel.class);
	    
	    assertNotNull(percentualInvestimento.getId());
	    assertNotNull(percentualInvestimento.getAcoes());
	    
	    
	}
	
	@Test
	@Order(7)
	public void postPercentualInvestimentoDadosInvalidosRetornaNotFound() throws JsonMappingException, JsonProcessingException {
		
		percentualInvestimentoDto.setRendaFixa((short)21);
		
		given().spec(specification)
		            .contentType("application/json")
		            .basePath("/percentualInvestimentos/usuario/9962c0e4-6e5d-4125-ad1c-7363cf72e45c")
		                .body(percentualInvestimentoDto)
		                .when()
		                .post()
		            .then()
		                .statusCode(404)
		                    .extract()
		                    .body()
		                        .asString();
		
	}
	
	@Test
	@Order(8)
	public void putPercentualInvestimentoDadosValidosRetornaPercentualInvestimento() throws JsonMappingException, JsonProcessingException {
		
		percentualInvestimentoDto.setRendaFixa((short)21);		
		
		var content = given().spec(specification)
	            .contentType("application/json")
	            .basePath("/percentualInvestimentos/"+MAIN_ID+"/usuario/7062c0e4-6e5d-4125-ad1c-7363cf72e45c")
	                .body(percentualInvestimentoDto)
	                .when()
	                .put()
	            .then()
	                .statusCode(200)
	                    .extract()
	                    .body()
	                        .asString();
		
		PercentualInvestimentoModel percentualInvestimento = objectMapper.readValue(content, PercentualInvestimentoModel.class);
	    
	    assertNotNull(percentualInvestimento.getId());
	    assertNotNull(percentualInvestimento.getAcoes());
	    
		
	}
	
	@Test
	@Order(9)
	public void putPercentualInvestimentoDadosInvalidosRetornaNotFound() throws JsonMappingException, JsonProcessingException {
		
		percentualInvestimentoDto.setRendaFixa((short)21);

		
		given().spec(specification)
	            .contentType("application/json")
	            .basePath("/percentualInvestimentos/9762c0e4-6e5d-4125-ad1c-7363cf72e459/usuario/7062c0e4-6e5d-4125-ad1c-7363cf72e45c")
	                .body(percentualInvestimentoDto)
	                .when()
	                .put()
	            .then()
	                .statusCode(404)
	                    .extract()
	                    .body()
	                        .asString();
		
	}
	
	@Test
	@Order(10)
	public void deletePercentualInvestimentoDadosValidosRetornaOk() throws JsonMappingException, JsonProcessingException {
		
		
		given().spec(specification)
			.contentType("application/json")
			.basePath("/percentualInvestimentos/"+MAIN_ID+"/usuario/7062c0e4-6e5d-4125-ad1c-7363cf72e45c")
		.when()
			.delete()
		.then()
			.statusCode(200);
		
	}
	
	@Test
	@Order(11)
	public void deletePercentualInvestimentoDadosInvalidosRetornaNotFound() throws JsonMappingException, JsonProcessingException {
		
		given().spec(specification)
		.contentType("application/json")
		.basePath("/percentualInvestimentos/e2c8879c-cd1b-48c7-9880-2b864c81fe96/usuario/7062c0e4-6e5d-4125-ad1c-7363cf72e45c")
		.when()
			.delete()
		.then()
			.statusCode(404);
		
	}
	

}

