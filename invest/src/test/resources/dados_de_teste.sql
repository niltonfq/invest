insert into usuario (id, email, username) values 
("7062c0e4-6e5d-4125-ad1c-7363cf72e45c", "email@email.com", "test"),
("8062c0e4-6e5d-4125-ad1c-7363cf72e45c", "email2@email.com", "test2");

INSERT INTO `ativo` (`id`, `cnpj`, `codigo`, `data_atualizacao`, `data_atualizacao_preco`, `data_criacao`, `moeda`, `nome`, `nota`, `observacao`, `preco_medio`, `quantidade_investida`, `quarentena`, `tipo_ativo`, `total_investido`, `valor_atual`, `banco_id`, `segmento_id`, `usuario_id`)
VALUES
	('d2c8879c-cd1b-48c7-9880-2b864c81fe96', NULL, 'PTBR3', '2023-03-01 00:00:00.000000', NULL, '2023-03-01 00:00:00.000000', 'R$', NULL, 0, NULL, 0.00, 0.00, 0, 'Acoes', 0.00, 0.00, NULL, NULL, '7062c0e4-6e5d-4125-ad1c-7363cf72e45c'),
	('e2c8879c-cd1b-48c7-9880-2b864c81fe96', NULL, 'PTBR3', '2023-03-01 00:00:00.000000', NULL, '2023-03-01 00:00:00.000000', 'R$', NULL, 0, NULL, 0.00, 0.00, 0, 'Acoes', 0.00, 0.00, NULL, NULL, '8062c0e4-6e5d-4125-ad1c-7363cf72e45c');

INSERT INTO `banco` (`id`, `cnpj`, `data_atualizacao`, `data_criacao`, `nome`, `numero`, `usuario_id`) 
VALUE 
	('51a4dee7-23e9-4213-9e13-2a5a53da7d95', '46729683000113', '2023-03-01 00:00:00.000000', '2023-03-01 00:00:00.000000', 'Bradesco','123456789','7062c0e4-6e5d-4125-ad1c-7363cf72e45c'),
    ('32380fb1-82aa-4766-b63e-0141f5df5207', '46729683000113', '2023-03-01 00:00:00.000000', '2023-03-01 00:00:00.000000', 'Bradesco','123456789','8062c0e4-6e5d-4125-ad1c-7363cf72e45c');
    
    
    