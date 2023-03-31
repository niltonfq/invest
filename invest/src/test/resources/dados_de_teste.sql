DELETE FROM `ativo` WHERE 1 = 1;

DELETE FROM `banco` WHERE 1 = 1;

DELETE FROM `segmento` WHERE 1 = 1;

DELETE FROM `usuario` WHERE 1 = 1;


insert into usuario (id, email, username) values 
("7062c0e4-6e5d-4125-ad1c-7363cf72e45c", "niltonfq@gmail.com", "Nilton"),
("8062c0e4-6e5d-4125-ad1c-7363cf72e45c", "email2@email.com", "test2");

INSERT INTO `ativo` (`id`, `cnpj`, `codigo`, `data_atualizacao`, `data_atualizacao_preco`, `data_criacao`, `moeda`, `nome`, `nota`, `observacao`, `preco_medio`, `quantidade_investida`, `quarentena`, `tipo_ativo`, `total_atual`, `total_investido`, `valor_atual`, `usuario_id`) 
VALUES                          ('d2c8879c-cd1b-48c7-9880-2b864c81fe96', '', 'PTBR3', '2023-03-01 00:00:00.000000', '2023-03-01 00:00:00.000000', '2023-03-01 00:00:00.000000', 'R$', '', 0, '', 0.00, 0.00, 0, 'Acoes', 0.00, 0.00, 0.00, '7062c0e4-6e5d-4125-ad1c-7363cf72e45c'),
                                ('e2c8879c-cd1b-48c7-9880-2b864c81fe96', '', 'PTBR3', '2023-03-01 00:00:00.000000', '2023-03-01 00:00:00.000000', '2023-03-01 00:00:00.000000', 'R$', '', 0, '', 0.00, 0.00, 0, 'Acoes', 0.00, 0.00, 0.00, '8062c0e4-6e5d-4125-ad1c-7363cf72e45c');
    
   

INSERT INTO `banco` (`id`, `cnpj`, `data_atualizacao`, `data_criacao`, `nome`, `numero`, `usuario_id`) 
VALUES 
	('51a4dee7-23e9-4213-9e13-2a5a53da7d95', '46729683000113', '2023-03-01 00:00:00.000000', '2023-03-01 00:00:00.000000', 'Bradesco','123456789','7062c0e4-6e5d-4125-ad1c-7363cf72e45c'),
    ('32380fb1-82aa-4766-b63e-0141f5df5207', '46729683000113', '2023-03-01 00:00:00.000000', '2023-03-01 00:00:00.000000', 'Bradesco','123456789','8062c0e4-6e5d-4125-ad1c-7363cf72e45c');

    
    
 INSERT INTO `segmento` (`id`, data_atualizacao, data_criacao , `nome`,`usuario_id`) 
VALUES 
	('e16613e7-cca0-46df-b2db-2dda5779e666','2023-03-01 00:00:00.000000','2023-03-01 00:00:00.000000', 'Shopping','7062c0e4-6e5d-4125-ad1c-7363cf72e45c'),
	('7e9999f1-8363-473b-8058-7fd92487328a','2023-03-01 00:00:00.000000','2023-03-01 00:00:00.000000', 'Bancario','8062c0e4-6e5d-4125-ad1c-7363cf72e45c' );

	

		
