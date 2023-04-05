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

import br.com.abs.invest.dtos.AtivoDto;
import br.com.abs.invest.enums.Moeda;
import br.com.abs.invest.enums.TipoAtivo;
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
	
	private static AtivoDto ativoDto;

	@BeforeAll
	public static void setup() {
		objectMapper = new ObjectMapper();
		objectMapper.registerModule(new JavaTimeModule());
		objectMapper.disable(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES);

		ativoDto = new AtivoDto();
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
	public void getAtivosDadosInvalidosRetornaVazio() throws Exception {
		var content = given().spec(specification).contentType("application/json")
				.basePath("/ativos/usuario/525c853f-dd20-4d1d-a1d7-59edd31b112f")
				.queryParams("page", 0, "limit", 5, "direction", "asc")
				.when().get()
				.then().statusCode(200)
				.extract().body().asString();
		
		JSONObject jsonObject = new JSONObject(content);
		String resp = jsonObject.get("content").toString();
		
		List<AtivoModel> ativos = objectMapper.readValue(resp, new TypeReference<List<AtivoModel>>() {});
		
		assertTrue(ativos.size() == 0);
		
	}
	
	@Test
	@Order(3)	
	public void getAtivosDadosValidosRetornaAtivos() throws Exception {
		var content = given().spec(specification).contentType("application/json")
				.basePath("/ativos/usuario/7062c0e4-6e5d-4125-ad1c-7363cf72e45c")
				.queryParams("page", 0, "limit", 5, "direction", "asc")
				.when().get()
				.then().statusCode(200)
				.extract().body().asString();
		
		
		JSONObject jsonObject = new JSONObject(content);
		String resp = jsonObject.get("content").toString();
		
		List<AtivoModel> ativos = objectMapper.readValue(resp, new TypeReference<List<AtivoModel>>() {});
		
		assertTrue(ativos.size() == 1);
		assertTrue(ativos.get(0).getCodigo().equals("PTBR3"));
		
	}

	@Test
	@Order(4)	
	public void getOneAtivoDadosValidoRetornaAtivo() throws Exception {
		var content = given().spec(specification).contentType("application/json")
				.basePath("/ativos/d2c8879c-cd1b-48c7-9880-2b864c81fe96/usuario/7062c0e4-6e5d-4125-ad1c-7363cf72e45c")
					.when().get()
				.then()
					.statusCode(200)
				.extract().body().asString();
		
		
		AtivoModel ativo = objectMapper.readValue(content, AtivoModel.class);
		    
		assertNotNull(ativo.getId());
		assertNotNull(ativo.getCodigo());
		
		assertEquals("PTBR3", ativo.getCodigo());

	}
	
	@Test
	@Order(5)	
	public void getOneAtivoDadosInvalidosRetornaNotFound() throws Exception {
		given().spec(specification).contentType("application/json")
				.basePath("/usuario/7062c0e4-6e5d-4125-ad1c-7363cf72e45c/ativos/e2c8879c-cd1b-48c7-9880-2b864c81fe96")
					.when().get()
				.then()
					.statusCode(404)
				.extract().body().asString();
		
	}
	
	@Test
	@Order(6)
	public void postAtivoDadosValidosRetornaCriado() throws JsonMappingException, JsonProcessingException {
	    
		ativoDto.setCodigo("BCFF11");
		ativoDto.setMoeda(Moeda.R$);
		ativoDto.setTipoAtivo(TipoAtivo.FII);
	    
	    var content = given().spec(specification)
	            .contentType("application/json")
	            .basePath("/ativos/usuario/7062c0e4-6e5d-4125-ad1c-7363cf72e45c")
	                .body(ativoDto)
	                .when()
	                .post()
	            .then()
	                .statusCode(201)
	                    .extract()
	                    .body()
	                        .asString();
	    
	    AtivoModel ativo = objectMapper.readValue(content, AtivoModel.class);
	    
	    assertNotNull(ativo.getId());
	    assertNotNull(ativo.getCodigo());
	    
	    assertEquals("BCFF11", ativo.getCodigo());
	    
	}
	
	@Test
	@Order(7)
	public void postAtivoDadosInvalidosRetornaNotFound() throws JsonMappingException, JsonProcessingException {
		
		ativoDto.setCodigo("BCFF11");
		ativoDto.setMoeda(Moeda.R$);
		ativoDto.setTipoAtivo(TipoAtivo.FII);
		
		
		given().spec(specification)
		            .contentType("application/json")
		            .basePath("/usuario/9962c0e4-6e5d-4125-ad1c-7363cf72e45c/ativos")
		                .body(ativoDto)
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
	public void putAtivoDadosValidosRetornaAtivo() throws JsonMappingException, JsonProcessingException {
		
		ativoDto.setCodigo("PTBR3");
		ativoDto.setMoeda(Moeda.R$);
		ativoDto.setTipoAtivo(TipoAtivo.FII);
		
		ativoDto.setNome("nome alterado");
		
		var content = given().spec(specification)
	            .contentType("application/json")
	            .basePath("/ativos/d2c8879c-cd1b-48c7-9880-2b864c81fe96/usuario/7062c0e4-6e5d-4125-ad1c-7363cf72e45c")
	                .body(ativoDto)
	                .when()
	                .put()
	            .then()
	                .statusCode(200)
	                    .extract()
	                    .body()
	                        .asString();
		
		AtivoModel ativo = objectMapper.readValue(content, AtivoModel.class);
	    
	    assertNotNull(ativo.getId());
	    assertNotNull(ativo.getCodigo());
	    
	    assertEquals("PTBR3", ativo.getCodigo());
	    assertEquals("nome alterado", ativo.getNome());
		
	}
	
	@Test
	@Order(9)
	public void putAtivoDadosInvalidosRetornaNotFound() throws JsonMappingException, JsonProcessingException {
		
		ativoDto.setCodigo("PTBR3");
		ativoDto.setMoeda(Moeda.R$);
		ativoDto.setTipoAtivo(TipoAtivo.FII);
		
		given().spec(specification)
	            .contentType("application/json")
	            .basePath("/usuario/7062c0e4-6e5d-4125-ad1c-7363cf72e45c/ativos/9762c0e4-6e5d-4125-ad1c-7363cf72e459")
	                .body(ativoDto)
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
	public void deleteAtivoDadosValidosRetornaOk() throws JsonMappingException, JsonProcessingException {
		
		
		given().spec(specification)
			.contentType("application/json")
			.basePath("/ativos/d2c8879c-cd1b-48c7-9880-2b864c81fe96/usuario/7062c0e4-6e5d-4125-ad1c-7363cf72e45c")
		.when()
			.delete()
		.then()
			.statusCode(200);
		
	}
	
	@Test
	@Order(11)
	public void deleteAtivoDadosInvalidosRetornaNotFound() throws JsonMappingException, JsonProcessingException {
		
		given().spec(specification)
		.contentType("application/json")
		.basePath("/usuario/7062c0e4-6e5d-4125-ad1c-7363cf72e45c/ativos/e2c8879c-cd1b-48c7-9880-2b864c81fe96")
		.when()
			.delete()
		.then()
			.statusCode(404);
		
	}
	

}
