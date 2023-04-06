package br.com.abs.invest.controllers;

import static io.restassured.RestAssured.given;
import static org.junit.Assert.assertEquals;
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

import br.com.abs.invest.dtos.SegmentoDto;
import br.com.abs.invest.models.SegmentoModel;
import io.restassured.builder.RequestSpecBuilder;
import io.restassured.filter.log.LogDetail;
import io.restassured.filter.log.RequestLoggingFilter;
import io.restassured.filter.log.ResponseLoggingFilter;
import io.restassured.specification.RequestSpecification;


@SpringBootTest(webEnvironment = SpringBootTest.WebEnvironment.DEFINED_PORT)
@TestMethodOrder(OrderAnnotation.class)
class SegmentoControllerTest {

	private static RequestSpecification specification;
	private static ObjectMapper objectMapper;
	
	private static SegmentoDto segmentoDto;

	@BeforeAll
	public static void setup() {
		objectMapper = new ObjectMapper();
		objectMapper.registerModule(new JavaTimeModule());
		objectMapper.disable(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES);

		segmentoDto = new SegmentoDto();
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
	public void getSegmentosDadosInvalidosRetornaVazio() throws Exception {
		      given().spec(specification).contentType("application/json")
				.basePath("/usuario/525c953f-dd20-4d1d-a1d7-59edd31b112f/segmentos")
				.queryParams("page", 0, "limit", 5, "direction", "asc")
				.when().get()
				.then().statusCode(404)
				.extract().body().asString();
	}
	
	@Test
	@Order(3)	
	public void getSegmentosDadosValidosRetornaSegmentos() throws Exception {
		var content = given().spec(specification).contentType("application/json")
				.basePath("/segmentos/usuario/7062c0e4-6e5d-4125-ad1c-7363cf72e45c")
				.queryParams("page", 0, "limit", 5, "direction", "asc")
				.when().get()
				.then().statusCode(200)
				.extract().body().asString();
		
		
		JSONObject jsonObject = new JSONObject(content);
		String resp = jsonObject.get("content").toString();
		
		List<SegmentoModel> segmentos = objectMapper.readValue(resp, new TypeReference<List<SegmentoModel>>() {});
		
		assertTrue(segmentos.size() == 1);
		assertTrue(segmentos.get(0).getNome().equals("Shopping"));
		
	}

	@Test
	@Order(4)	
	public void getOneSegmentoDadosValidoRetornaSegmento() throws Exception {
		var content = given().spec(specification).contentType("application/json")
				.basePath("/segmentos/e16613e7-cca0-46df-b2db-2dda5779e666/usuario/7062c0e4-6e5d-4125-ad1c-7363cf72e45c")
					.when().get()
				.then()
					.statusCode(200)
				.extract().body().asString();
		
		
		SegmentoModel segmento = objectMapper.readValue(content, SegmentoModel.class);
		    
		assertNotNull(segmento.getId());
		assertNotNull(segmento.getNome());
		
		assertEquals("Shopping", segmento.getNome());

	}
	
	@Test
	@Order(5)	
	public void getOneSegmentoDadosInvalidosRetornaNotFound() throws Exception {
		given().spec(specification).contentType("application/json")
				.basePath("/segmentos/32380fb1-82aa-4766-b63e-0141f5df5207/usuario/7062c0e4-6e5d-4125-ad1c-7363cf72e45c")
					.when().get()
				.then()
					.statusCode(404)
				.extract().body().asString();
		
	}
	
	@Test
	@Order(6)
	public void postSegmentoDadosValidosRetornaCriado() throws JsonMappingException, JsonProcessingException {
	    
		segmentoDto.setNome("Itau");

	    var content = given().spec(specification)
	            .contentType("application/json")
	            .basePath("/segmentos/usuario/7062c0e4-6e5d-4125-ad1c-7363cf72e45c")
	                .body(segmentoDto)
	                .when()
	                .post()
	            .then()
	                .statusCode(201)
	                    .extract()
	                    .body()
	                        .asString();
	    
	    SegmentoModel segmento = objectMapper.readValue(content, SegmentoModel.class);
	    
	    assertNotNull(segmento.getId());
	    assertNotNull(segmento.getNome());
	    
	    assertEquals("Itau", segmento.getNome());
	    
	}
	
	@Test
	@Order(7)
	public void postSegmentoDadosInvalidosRetornaNotFound() throws JsonMappingException, JsonProcessingException {
		
		segmentoDto.setNome("BCFF11");

		given().spec(specification)
		            .contentType("application/json")
		            .basePath("/segmentos/usuario/9962c0e4-6e5d-4125-ad1c-7363cf72e45c")
		                .body(segmentoDto)
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
	public void putSegmentoDadosValidosRetornaSegmento() throws JsonMappingException, JsonProcessingException {
		
		segmentoDto.setNome("Bradesco");		
		
		var content = given().spec(specification)
	            .contentType("application/json")
	            .basePath("/segmentos/e16613e7-cca0-46df-b2db-2dda5779e666/usuario/7062c0e4-6e5d-4125-ad1c-7363cf72e45c")
	                .body(segmentoDto)
	                .when()
	                .put()
	            .then()
	                .statusCode(200)
	                    .extract()
	                    .body()
	                        .asString();
		
		SegmentoModel segmento = objectMapper.readValue(content, SegmentoModel.class);
	    
	    assertNotNull(segmento.getId());
	    assertNotNull(segmento.getNome());
	    
	    assertEquals("Bradesco", segmento.getNome());
		
	}
	
	@Test
	@Order(9)
	public void putSegmentoDadosInvalidosRetornaNotFound() throws JsonMappingException, JsonProcessingException {
		
		segmentoDto.setNome("PTBR3");

		
		given().spec(specification)
	            .contentType("application/json")
	            .basePath("/segmentos/9762c0e4-6e5d-4125-ad1c-7363cf72e459/usuario/7062c0e4-6e5d-4125-ad1c-7363cf72e45c")
	                .body(segmentoDto)
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
	public void deleteSegmentoDadosValidosRetornaOk() throws JsonMappingException, JsonProcessingException {
		
		
		given().spec(specification)
			.contentType("application/json")
			.basePath("/segmentos/e16613e7-cca0-46df-b2db-2dda5779e666/usuario/7062c0e4-6e5d-4125-ad1c-7363cf72e45c")
		.when()
			.delete()
		.then()
			.statusCode(200);
		
	}
	
	@Test
	@Order(11)
	public void deleteSegmentoDadosInvalidosRetornaNotFound() throws JsonMappingException, JsonProcessingException {
		
		given().spec(specification)
		.contentType("application/json")
		.basePath("/segmentos/e2c8879c-cd1b-48c7-9880-2b864c81fe96/usuario/7062c0e4-6e5d-4125-ad1c-7363cf72e45c")
		.when()
			.delete()
		.then()
			.statusCode(404);
		
	}
	

}

