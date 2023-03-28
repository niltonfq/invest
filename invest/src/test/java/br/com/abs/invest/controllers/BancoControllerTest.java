package br.com.abs.invest.controllers;

import static io.restassured.RestAssured.given;
import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;
import static org.junit.Assert.assertTrue;

import java.util.List;
import java.util.UUID;

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

import br.com.abs.invest.dtos.BancoDto;
import br.com.abs.invest.dtos.UsuarioDto;
import br.com.abs.invest.models.BancoModel;
import io.restassured.builder.RequestSpecBuilder;
import io.restassured.filter.log.LogDetail;
import io.restassured.filter.log.RequestLoggingFilter;
import io.restassured.filter.log.ResponseLoggingFilter;
import io.restassured.specification.RequestSpecification;


@SpringBootTest(webEnvironment = SpringBootTest.WebEnvironment.DEFINED_PORT)
@TestMethodOrder(OrderAnnotation.class)
class BancoControllerTest {

	private static RequestSpecification specification;
	private static ObjectMapper objectMapper;
	
	private static BancoDto bancoDto;

	@BeforeAll
	public static void setup() {
		objectMapper = new ObjectMapper();
		objectMapper.registerModule(new JavaTimeModule());
		objectMapper.disable(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES);

		bancoDto = new BancoDto();
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
	public void getBancosDadosInvalidosRetornaVazio() throws Exception {
		var content = given().spec(specification).contentType("application/json")
				.basePath("/usuario/525c853f-dd20-4d1d-a1d7-59edd31b112f/bancos")
				.queryParams("page", 0, "limit", 5, "direction", "asc")
				.when().get()
				.then().statusCode(200)
				.extract().body().asString();
		
		JSONObject jsonObject = new JSONObject(content);
		String resp = jsonObject.get("content").toString();
		
		List<BancoModel> bancos = objectMapper.readValue(resp, new TypeReference<List<BancoModel>>() {});
		
		assertTrue(bancos.size() == 0);
		
	}
	
	@Test
	@Order(3)	
	public void getBancosDadosValidosRetornaBancos() throws Exception {
		var content = given().spec(specification).contentType("application/json")
				.basePath("/usuario/7062c0e4-6e5d-4125-ad1c-7363cf72e45c/bancos")
				.queryParams("page", 0, "limit", 5, "direction", "asc")
				.when().get()
				.then().statusCode(200)
				.extract().body().asString();
		
		
		JSONObject jsonObject = new JSONObject(content);
		String resp = jsonObject.get("content").toString();
		
		List<BancoModel> bancos = objectMapper.readValue(resp, new TypeReference<List<BancoModel>>() {});
		
		assertTrue(bancos.size() == 1);
		assertTrue(bancos.get(0).getNome().equals("Bradesco"));
		
	}

	@Test
	@Order(4)	
	public void getOneBancoDadosValidoRetornaBanco() throws Exception {
		var content = given().spec(specification).contentType("application/json")
				.basePath("/usuario/7062c0e4-6e5d-4125-ad1c-7363cf72e45c/bancos/d2c8879c-cd1b-48c7-9880-2b864c81fe96")
					.when().get()
				.then()
					.statusCode(200)
				.extract().body().asString();
		
		
		BancoModel banco = objectMapper.readValue(content, BancoModel.class);
		    
		assertNotNull(banco.getId());
		assertNotNull(banco.getNome());
		
		assertEquals("PTBR3", banco.getNome());

	}
	
	@Test
	@Order(5)	
	public void getOneBancoDadosInvalidosRetornaNotFound() throws Exception {
		given().spec(specification).contentType("application/json")
				.basePath("/usuario/7062c0e4-6e5d-4125-ad1c-7363cf72e45c/bancos/32380fb1-82aa-4766-b63e-0141f5df5207")
					.when().get()
				.then()
					.statusCode(404)
				.extract().body().asString();
		
	}
	
	@Test
	@Order(6)
	public void postBancoDadosValidosRetornaCriado() throws JsonMappingException, JsonProcessingException {
	    
		bancoDto.setNome("Bradesco");

	    
	    UsuarioDto usuario = new UsuarioDto();
		usuario.setId(UUID.fromString("7062c0e4-6e5d-4125-ad1c-7363cf72e45c"));
		bancoDto.setUsuario(usuario);
		
	    var content = given().spec(specification)
	            .contentType("application/json")
	            .basePath("/usuario/7062c0e4-6e5d-4125-ad1c-7363cf72e45c/bancos")
	                .body(bancoDto)
	                .when()
	                .post()
	            .then()
	                .statusCode(201)
	                    .extract()
	                    .body()
	                        .asString();
	    
	    BancoModel banco = objectMapper.readValue(content, BancoModel.class);
	    
	    assertNotNull(banco.getId());
	    assertNotNull(banco.getNome());
	    
	    assertEquals("Itau", banco.getNome());
	    
	}
	
	@Test
	@Order(7)
	public void postBancoDadosInvalidosRetornaNotFound() throws JsonMappingException, JsonProcessingException {
		
		bancoDto.setNome("BCFF11");

		
		UsuarioDto usuario = new UsuarioDto();
		usuario.setId(UUID.fromString("7762c0e4-6e5d-4125-ad1c-7363cf72e45c"));
		bancoDto.setUsuario(usuario);
		
		given().spec(specification)
		            .contentType("application/json")
		            .basePath("/usuario/9962c0e4-6e5d-4125-ad1c-7363cf72e45c/bancos")
		                .body(bancoDto)
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
	public void putBancoDadosValidosRetornaBanco() throws JsonMappingException, JsonProcessingException {
		
		bancoDto.setNome("Itau");

		
		UsuarioDto usuario = new UsuarioDto();
		usuario.setId(UUID.fromString("7762c0e4-6e5d-4125-ad1c-7363cf72e45c"));
		bancoDto.setUsuario(usuario);
		bancoDto.setNome("nome alterado");
		
		var content = given().spec(specification)
	            .contentType("application/json")
	            .basePath("/usuario/7062c0e4-6e5d-4125-ad1c-7363cf72e45c/bancos/51a4dee7-23e9-4213-9e13-2a5a53da7d95")
	                .body(bancoDto)
	                .when()
	                .put()
	            .then()
	                .statusCode(200)
	                    .extract()
	                    .body()
	                        .asString();
		
		BancoModel banco = objectMapper.readValue(content, BancoModel.class);
	    
	    assertNotNull(banco.getId());
	    assertNotNull(banco.getNome());
	    
	    assertEquals("Bradesco", banco.getNome());
	    assertEquals("nome alterado", banco.getNome());
		
	}
	
	@Test
	@Order(9)
	public void putBancoDadosInvalidosRetornaNotFound() throws JsonMappingException, JsonProcessingException {
		
		bancoDto.setNome("PTBR3");

		
		given().spec(specification)
	            .contentType("application/json")
	            .basePath("/usuario/7062c0e4-6e5d-4125-ad1c-7363cf72e45c/bancos/9762c0e4-6e5d-4125-ad1c-7363cf72e459")
	                .body(bancoDto)
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
	public void deleteBancoDadosValidosRetornaOk() throws JsonMappingException, JsonProcessingException {
		
		
		given().spec(specification)
			.contentType("application/json")
			.basePath("/usuario/7062c0e4-6e5d-4125-ad1c-7363cf72e45c/bancos/51a4dee7-23e9-4213-9e13-2a5a53da7d95")
		.when()
			.delete()
		.then()
			.statusCode(200);
		
	}
	
	@Test
	@Order(11)
	public void deleteBancoDadosInvalidosRetornaNotFound() throws JsonMappingException, JsonProcessingException {
		
		given().spec(specification)
		.contentType("application/json")
		.basePath("/usuario/7062c0e4-6e5d-4125-ad1c-7363cf72e45c/bancos/e2c8879c-cd1b-48c7-9880-2b864c81fe96")
		.when()
			.delete()
		.then()
			.statusCode(404);
		
	}
	

}

