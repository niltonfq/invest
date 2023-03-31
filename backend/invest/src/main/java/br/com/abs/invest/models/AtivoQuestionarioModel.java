package br.com.abs.invest.models;


import java.io.Serializable;
import java.time.LocalDateTime;
import java.util.UUID;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.UniqueConstraint;

import org.hibernate.annotations.Type;
import org.springframework.hateoas.RepresentationModel;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonFormat.Shape;
import com.fasterxml.jackson.annotation.JsonInclude;





@JsonInclude(JsonInclude.Include.NON_NULL)
@Entity
@Table(name = "ativoQuestionario",
	uniqueConstraints = { @UniqueConstraint(columnNames = {"usuarioId", "ativoId" }) }
)
public class AtivoQuestionarioModel extends RepresentationModel<AtivoQuestionarioModel> implements Serializable {
	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	@Type(type = "uuid-char")
	@Column(nullable = false, columnDefinition="char(36)")
	private UUID id;
	
	@JsonFormat(shape = Shape.STRING, pattern = "dd-MM-yyyy HH:mm:ss")
	@Column(nullable = false)
	private LocalDateTime dataCriacao;
	
	@JsonFormat(shape = Shape.STRING, pattern = "dd-MM-yyyy HH:mm:ss")
	@Column(nullable = false)
	private LocalDateTime dataAtualizacao;
	
	@ManyToOne
	@JoinColumn(name="usuarioId", nullable=false)
	UsuarioModel usuario;
	
	@ManyToOne
	@JoinColumn(nullable = false ,name = "ativoId")
	private AtivoModel ativo;
	
	@ManyToOne
	@JoinColumn(nullable = false ,name = "questionarioId")
	private QuestionarioModel questionario;
	
	@Column(length = 6)
	private short relevante;
	
	@Column(length = 255)
	private String levantamento;	
	
	@Column(length = 6)
	private short nota;

	public AtivoQuestionarioModel() {
		super();
	}

	public UUID getId() {
		return id;
	}

	public void setId(UUID id) {
		this.id = id;
	}

	public LocalDateTime getDataCriacao() {
		return dataCriacao;
	}

	public void setDataCriacao(LocalDateTime dataCriacao) {
		this.dataCriacao = dataCriacao;
	}

	public LocalDateTime getDataAtualizacao() {
		return dataAtualizacao;
	}

	public void setDataAtualizacao(LocalDateTime dataAtualizacao) {
		this.dataAtualizacao = dataAtualizacao;
	}

	public UsuarioModel getUsuario() {
		return usuario;
	}

	public void setUsuario(UsuarioModel usuario) {
		this.usuario = usuario;
	}

	public AtivoModel getAtivo() {
		return ativo;
	}

	public void setAtivo(AtivoModel ativo) {
		this.ativo = ativo;
	}

	public QuestionarioModel getQuestionario() {
		return questionario;
	}

	public void setQuestionario(QuestionarioModel questionario) {
		this.questionario = questionario;
	}

	public short getRelevante() {
		return relevante;
	}

	public void setRelevante(short relevante) {
		this.relevante = relevante;
	}

	public String getLevantamento() {
		return levantamento;
	}

	public void setLevantamento(String levantamento) {
		this.levantamento = levantamento;
	}

	public short getNota() {
		return nota;
	}

	public void setNota(short nota) {
		this.nota = nota;
	}	
	
	
	


	
	
	
	
}

