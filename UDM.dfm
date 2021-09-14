object DM: TDM
  OldCreateOrder = False
  Height = 479
  Width = 848
  object Conexao: TADOConnection
    ConnectionString = 
      'Provider=SQLOLEDB.1;Password=123456;Persist Security Info=True;U' +
      'ser ID=sa;Initial Catalog=sisgcv;Data Source=DESKTOP-1SAI53V\SQL' +
      'EXPRESS'
    LoginPrompt = False
    Mode = cmShareDenyNone
    Provider = 'SQLOLEDB.1'
    Left = 32
    Top = 32
  end
  object qry_cad_cliente: TADOQuery
    Connection = Conexao
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      
        'SELECT cli_cod, cli_nome, cli_cpf, cli_renda, cli_ativo, cli_dt_' +
        'nasc, cli_img, cli_email FROM CLIENTES')
    Left = 272
    Top = 32
    object qry_cad_clientecli_cod: TAutoIncField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'cli_cod'
      ReadOnly = True
    end
    object qry_cad_clientecli_nome: TStringField
      DisplayLabel = 'Nome'
      FieldName = 'cli_nome'
      Size = 80
    end
    object qry_cad_clientecli_cpf: TStringField
      DisplayLabel = 'CPF'
      FieldName = 'cli_cpf'
      Size = 11
    end
    object qry_cad_clientecli_renda: TBCDField
      DisplayLabel = 'Renda'
      FieldName = 'cli_renda'
      currency = True
      Precision = 8
      Size = 2
    end
    object qry_cad_clientecli_ativo: TBooleanField
      DisplayLabel = 'Ativo'
      FieldName = 'cli_ativo'
    end
    object qry_cad_clientecli_dt_nasc: TWideStringField
      DisplayLabel = 'Nascimento'
      FieldName = 'cli_dt_nasc'
      Size = 10
    end
    object qry_cad_clientecli_img: TStringField
      DisplayLabel = 'Imagem'
      FieldName = 'cli_img'
      Size = 500
    end
    object qry_cad_clientecli_email: TStringField
      DisplayLabel = 'Email'
      FieldName = 'cli_email'
      Size = 100
    end
  end
  object qry_cad_fornecedor: TADOQuery
    Connection = Conexao
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      
        'SELECT forn_cod, forn_nm_fantasia, forn_razao_social, forn_dt_ca' +
        'd, forn_cnpj, forn_ativo, forn_img, forn_observacoes FROM FORNEC' +
        'EDORES')
    Left = 136
    Top = 32
    object qry_cad_fornecedorforn_cod: TAutoIncField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'forn_cod'
      ReadOnly = True
    end
    object qry_cad_fornecedorforn_nm_fantasia: TStringField
      DisplayLabel = 'Nome'
      FieldName = 'forn_nm_fantasia'
      Size = 50
    end
    object qry_cad_fornecedorforn_razao_social: TStringField
      DisplayLabel = 'Raz'#227'o Social'
      FieldName = 'forn_razao_social'
      Size = 100
    end
    object qry_cad_fornecedorforn_dt_cad: TWideStringField
      DisplayLabel = 'Data de cadastro'
      FieldName = 'forn_dt_cad'
      Size = 10
    end
    object qry_cad_fornecedorforn_cnpj: TStringField
      DisplayLabel = 'CNPJ'
      FieldName = 'forn_cnpj'
      Size = 14
    end
    object qry_cad_fornecedorforn_ativo: TBooleanField
      DisplayLabel = 'Ativo'
      FieldName = 'forn_ativo'
    end
    object qry_cad_fornecedorforn_img: TStringField
      DisplayLabel = 'Imagem'
      FieldName = 'forn_img'
      Size = 500
    end
    object qry_cad_fornecedorforn_observacoes: TStringField
      DisplayLabel = 'Observa'#231#245'es'
      FieldName = 'forn_observacoes'
      Size = 500
    end
  end
  object qry_cad_funcionario: TADOQuery
    Connection = Conexao
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      
        'SELECT fun_cod, fun_nome, fun_dt_nasc, fun_salario, fun_login, f' +
        'un_senha, fun_tp_usu FROM FUNCIONARIOS')
    Left = 384
    Top = 32
    object qry_cad_funcionariofun_cod: TAutoIncField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'fun_cod'
      ReadOnly = True
    end
    object qry_cad_funcionariofun_nome: TStringField
      DisplayLabel = 'Nome'
      FieldName = 'fun_nome'
      Size = 80
    end
    object qry_cad_funcionariofun_dt_nasc: TWideStringField
      DisplayLabel = 'Data de nascimento'
      FieldName = 'fun_dt_nasc'
      Size = 10
    end
    object qry_cad_funcionariofun_salario: TBCDField
      DisplayLabel = 'Sal'#225'rio'
      FieldName = 'fun_salario'
      Precision = 8
      Size = 2
    end
    object qry_cad_funcionariofun_login: TStringField
      DisplayLabel = 'Login'
      FieldName = 'fun_login'
      Size = 12
    end
    object qry_cad_funcionariofun_senha: TStringField
      DisplayLabel = 'Senha'
      FieldName = 'fun_senha'
      Size = 12
    end
    object qry_cad_funcionariofun_tp_usu: TStringField
      DisplayLabel = 'Tipo usu'#225'rio'
      FieldName = 'fun_tp_usu'
    end
  end
  object qry_pesq_fornecedor: TADOQuery
    Connection = Conexao
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      
        'SELECT forn_cod, forn_nm_fantasia, forn_razao_social, forn_dt_ca' +
        'd, forn_cnpj, forn_ativo, forn_img, forn_observacoes FROM FORNEC' +
        'EDORES')
    Left = 136
    Top = 104
    object qry_pesq_fornecedorforn_cod: TAutoIncField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'forn_cod'
      ReadOnly = True
    end
    object qry_pesq_fornecedorforn_nm_fantasia: TStringField
      DisplayLabel = 'Nome'
      FieldName = 'forn_nm_fantasia'
      Size = 50
    end
    object qry_pesq_fornecedorforn_razao_social: TStringField
      DisplayLabel = 'Raz'#227'o Social'
      FieldName = 'forn_razao_social'
      Size = 100
    end
    object qry_pesq_fornecedorforn_dt_cad: TWideStringField
      DisplayLabel = 'Data de cadastro'
      FieldName = 'forn_dt_cad'
      Size = 10
    end
    object qry_pesq_fornecedorforn_cnpj: TStringField
      DisplayLabel = 'CNPJ'
      FieldName = 'forn_cnpj'
      Size = 14
    end
    object qry_pesq_fornecedorforn_ativo: TBooleanField
      DisplayLabel = 'Ativo'
      FieldName = 'forn_ativo'
      DisplayValues = 'Sim;N'#227'o'
    end
    object qry_pesq_fornecedorforn_img: TStringField
      DisplayLabel = 'Imagem'
      FieldName = 'forn_img'
      Size = 500
    end
    object qry_pesq_fornecedorforn_observacoes: TStringField
      DisplayLabel = 'Observa'#231#245'es'
      FieldName = 'forn_observacoes'
      Size = 500
    end
  end
  object qry_cad_produto: TADOQuery
    Connection = Conexao
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      
        'SELECT prod_cod, prod_nome, prod_img, prod_estq, prod_vlr_comp, ' +
        'prod_vlr_vnd, prod_lucro FROM PRODUTOS')
    Left = 504
    Top = 32
    object qry_cad_produtoprod_cod: TAutoIncField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'prod_cod'
      ReadOnly = True
    end
    object qry_cad_produtoprod_nome: TStringField
      DisplayLabel = 'Nome'
      FieldName = 'prod_nome'
      Size = 50
    end
    object qry_cad_produtoprod_img: TStringField
      DisplayLabel = 'Imagem'
      FieldName = 'prod_img'
      Size = 500
    end
    object qry_cad_produtoprod_estq: TIntegerField
      DisplayLabel = 'Estoque'
      FieldName = 'prod_estq'
    end
    object qry_cad_produtoprod_vlr_comp: TBCDField
      DisplayLabel = 'Valor compra'
      FieldName = 'prod_vlr_comp'
      Precision = 8
      Size = 2
    end
    object qry_cad_produtoprod_vlr_vnd: TBCDField
      DisplayLabel = 'Valor venda'
      FieldName = 'prod_vlr_vnd'
      Precision = 8
      Size = 2
    end
    object qry_cad_produtoprod_lucro: TIntegerField
      DisplayLabel = 'Porcentual de lucro'
      FieldName = 'prod_lucro'
    end
  end
  object qry_pesq_cliente: TADOQuery
    Connection = Conexao
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      
        'SELECT cli_cod, cli_nome, cli_cpf, cli_renda, cli_ativo, cli_dt_' +
        'nasc, cli_img, cli_email FROM CLIENTES')
    Left = 272
    Top = 104
    object qry_pesq_clientecli_cod: TAutoIncField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'cli_cod'
      ReadOnly = True
    end
    object qry_pesq_clientecli_nome: TStringField
      DisplayLabel = 'Nome'
      FieldName = 'cli_nome'
      Size = 80
    end
    object qry_pesq_clientecli_cpf: TStringField
      DisplayLabel = 'CPF'
      FieldName = 'cli_cpf'
      Size = 11
    end
    object qry_pesq_clientecli_renda: TBCDField
      DisplayLabel = 'Renda'
      FieldName = 'cli_renda'
      currency = True
      Precision = 8
      Size = 2
    end
    object qry_pesq_clientecli_ativo: TBooleanField
      DisplayLabel = 'Ativo'
      FieldName = 'cli_ativo'
    end
    object qry_pesq_clientecli_dt_nasc: TWideStringField
      DisplayLabel = 'Nascimento'
      FieldName = 'cli_dt_nasc'
      Size = 10
    end
    object qry_pesq_clientecli_img: TStringField
      DisplayLabel = 'Imagem'
      FieldName = 'cli_img'
      Size = 500
    end
    object qry_pesq_clientecli_email: TStringField
      DisplayLabel = 'Email'
      FieldName = 'cli_email'
      Size = 100
    end
  end
  object qry_pesq_funcionario: TADOQuery
    Connection = Conexao
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      
        'SELECT fun_cod, fun_nome, fun_dt_nasc, fun_salario, fun_login, f' +
        'un_senha, fun_tp_usu FROM FUNCIONARIOS')
    Left = 384
    Top = 104
    object qry_pesq_funcionariofun_cod: TAutoIncField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'fun_cod'
      ReadOnly = True
    end
    object qry_pesq_funcionariofun_nome: TStringField
      DisplayLabel = 'Nome'
      FieldName = 'fun_nome'
      Size = 80
    end
    object qry_pesq_funcionariofun_dt_nasc: TWideStringField
      DisplayLabel = 'Data de nascimento'
      FieldName = 'fun_dt_nasc'
      Size = 10
    end
    object qry_pesq_funcionariofun_salario: TBCDField
      DisplayLabel = 'Sal'#225'rio'
      FieldName = 'fun_salario'
      Precision = 8
      Size = 2
    end
    object qry_pesq_funcionariofun_login: TStringField
      DisplayLabel = 'Login'
      FieldName = 'fun_login'
      Size = 12
    end
    object qry_pesq_funcionariofun_senha: TStringField
      DisplayLabel = 'Senha'
      FieldName = 'fun_senha'
      Size = 12
    end
    object qry_pesq_funcionariofun_tp_usu: TStringField
      DisplayLabel = 'Tipo de usu'#225'rio'
      FieldName = 'fun_tp_usu'
    end
  end
  object qry_pesq_produto: TADOQuery
    Connection = Conexao
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      
        'SELECT prod_cod, prod_nome, prod_img, prod_estq, prod_vlr_comp, ' +
        'prod_vlr_vnd, prod_lucro FROM PRODUTOS')
    Left = 504
    Top = 104
    object qry_pesq_produtoprod_cod: TAutoIncField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'prod_cod'
      ReadOnly = True
    end
    object qry_pesq_produtoprod_nome: TStringField
      DisplayLabel = 'Nome'
      FieldName = 'prod_nome'
      Size = 50
    end
    object qry_pesq_produtoprod_img: TStringField
      DisplayLabel = 'Imagem'
      FieldName = 'prod_img'
      Size = 500
    end
    object qry_pesq_produtoprod_estq: TIntegerField
      DisplayLabel = 'Estoque'
      FieldName = 'prod_estq'
    end
    object qry_pesq_produtoprod_vlr_comp: TBCDField
      DisplayLabel = 'Valor de compra'
      FieldName = 'prod_vlr_comp'
      Precision = 8
      Size = 2
    end
    object qry_pesq_produtoprod_vlr_vnd: TBCDField
      DisplayLabel = 'Valor de venda'
      FieldName = 'prod_vlr_vnd'
      Precision = 8
      Size = 2
    end
    object qry_pesq_produtoprod_lucro: TIntegerField
      DisplayLabel = 'Porcentagem de lucro'
      FieldName = 'prod_lucro'
    end
  end
  object qry_cad_forn_endereco: TADOQuery
    Connection = Conexao
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      
        'SELECT forn_cod, for_end_cep, for_end_logradouro, for_end_comple' +
        'mento, for_end_bairro, for_end_localizacao, for_end_uf, for_end_' +
        'numero, for_end_referencia FROM FORNECEDOR_ENDERECO')
    Left = 136
    Top = 184
    object qry_cad_forn_enderecoforn_cod: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'forn_cod'
    end
    object qry_cad_forn_enderecofor_end_cep: TStringField
      DisplayLabel = 'CEP'
      FieldName = 'for_end_cep'
      Size = 9
    end
    object qry_cad_forn_enderecofor_end_logradouro: TStringField
      DisplayLabel = 'Logradouro'
      FieldName = 'for_end_logradouro'
      Size = 100
    end
    object qry_cad_forn_enderecofor_end_complemento: TStringField
      DisplayLabel = 'Complemento'
      FieldName = 'for_end_complemento'
      Size = 50
    end
    object qry_cad_forn_enderecofor_end_bairro: TStringField
      DisplayLabel = 'Bairro'
      FieldName = 'for_end_bairro'
      Size = 50
    end
    object qry_cad_forn_enderecofor_end_localizacao: TStringField
      DisplayLabel = 'Localiza'#231#227'o'
      FieldName = 'for_end_localizacao'
      Size = 80
    end
    object qry_cad_forn_enderecofor_end_uf: TStringField
      DisplayLabel = 'UF'
      FieldName = 'for_end_uf'
      FixedChar = True
      Size = 2
    end
    object qry_cad_forn_enderecofor_end_numero: TStringField
      DisplayLabel = 'n'#186
      FieldName = 'for_end_numero'
      Size = 10
    end
    object qry_cad_forn_enderecofor_end_referencia: TStringField
      DisplayLabel = 'Refer'#234'ncia'
      FieldName = 'for_end_referencia'
      Size = 100
    end
  end
  object qry_cad_cli_endereco: TADOQuery
    Connection = Conexao
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      
        'SELECT cli_cod, cli_end_cep, cli_end_logradouro, cli_end_complem' +
        'ento, cli_end_bairro, cli_end_localizacao, cli_end_uf, cli_end_n' +
        'umero, cli_end_referencia FROM CLIENTE_ENDERECO')
    Left = 272
    Top = 184
    object qry_cad_cli_enderecocli_cod: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'cli_cod'
    end
    object qry_cad_cli_enderecocli_end_cep: TStringField
      DisplayLabel = 'CEP'
      FieldName = 'cli_end_cep'
      Size = 9
    end
    object qry_cad_cli_enderecocli_end_logradouro: TStringField
      DisplayLabel = 'Logradouro'
      FieldName = 'cli_end_logradouro'
      Size = 100
    end
    object qry_cad_cli_enderecocli_end_complemento: TStringField
      DisplayLabel = 'Complemento'
      FieldName = 'cli_end_complemento'
      Size = 50
    end
    object qry_cad_cli_enderecocli_end_bairro: TStringField
      DisplayLabel = 'Bairro'
      FieldName = 'cli_end_bairro'
      Size = 50
    end
    object qry_cad_cli_enderecocli_end_localizacao: TStringField
      DisplayLabel = 'Localiza'#231#227'o'
      FieldName = 'cli_end_localizacao'
      Size = 80
    end
    object qry_cad_cli_enderecocli_end_uf: TStringField
      DisplayLabel = 'UF'
      FieldName = 'cli_end_uf'
      FixedChar = True
      Size = 2
    end
    object qry_cad_cli_enderecocli_end_numero: TStringField
      DisplayLabel = 'n'#186
      FieldName = 'cli_end_numero'
      Size = 10
    end
    object qry_cad_cli_enderecocli_end_referencia: TStringField
      DisplayLabel = 'Refer'#234'ncia'
      FieldName = 'cli_end_referencia'
      Size = 100
    end
  end
  object qry_cad_forn_tel: TADOQuery
    Connection = Conexao
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      
        'SELECT forn_tel_cod, forn_tel_contato, forn_tel_tipo, forn_tel_n' +
        'umero, forn_tel_operadora, forn_cod FROM FORNECEDOR_TELEFONES')
    Left = 136
    Top = 256
    object qry_cad_forn_telforn_tel_cod: TAutoIncField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'forn_tel_cod'
      ReadOnly = True
    end
    object qry_cad_forn_telforn_tel_contato: TStringField
      DisplayLabel = 'Contato'
      FieldName = 'forn_tel_contato'
      Size = 80
    end
    object qry_cad_forn_telforn_tel_tipo: TStringField
      DisplayLabel = 'Tipo'
      FieldName = 'forn_tel_tipo'
    end
    object qry_cad_forn_telforn_tel_numero: TStringField
      DisplayLabel = 'N'#250'mero'
      FieldName = 'forn_tel_numero'
    end
    object qry_cad_forn_telforn_tel_operadora: TStringField
      DisplayLabel = 'Operadora'
      FieldName = 'forn_tel_operadora'
      Size = 15
    end
    object qry_cad_forn_telforn_cod: TIntegerField
      DisplayLabel = 'Fornecedor'
      FieldName = 'forn_cod'
    end
  end
  object qry_cad_cli_tel: TADOQuery
    Connection = Conexao
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      
        'SELECT cli_tel_cod, cli_tel_contato, cli_tel_tipo, cli_tel_numer' +
        'o, cli_tel_operadora, cli_cod FROM CLIENTE_TELEFONES')
    Left = 272
    Top = 256
    object qry_cad_cli_telcli_tel_cod: TAutoIncField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'cli_tel_cod'
      ReadOnly = True
    end
    object qry_cad_cli_telcli_tel_contato: TStringField
      DisplayLabel = 'Contato'
      FieldName = 'cli_tel_contato'
      Size = 80
    end
    object qry_cad_cli_telcli_tel_tipo: TStringField
      DisplayLabel = 'Tipo'
      FieldName = 'cli_tel_tipo'
    end
    object qry_cad_cli_telcli_tel_numero: TStringField
      DisplayLabel = 'N'#250'mero'
      FieldName = 'cli_tel_numero'
    end
    object qry_cad_cli_telcli_tel_operadora: TStringField
      DisplayLabel = 'Operadora'
      FieldName = 'cli_tel_operadora'
      Size = 15
    end
    object qry_cad_cli_telcli_cod: TIntegerField
      DisplayLabel = 'Cliente'
      FieldName = 'cli_cod'
    end
  end
  object qry_cad_venda: TADOQuery
    Connection = Conexao
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT vnd_cod, cli_cod, fun_cod, vnd_data FROM VENDAS')
    Left = 616
    Top = 32
    object qry_cad_vendavnd_cod: TAutoIncField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'vnd_cod'
      ReadOnly = True
    end
    object qry_cad_vendacli_cod: TIntegerField
      DisplayLabel = 'Cliente'
      FieldName = 'cli_cod'
    end
    object qry_cad_vendafun_cod: TIntegerField
      DisplayLabel = 'Funcion'#225'rio'
      FieldName = 'fun_cod'
    end
    object qry_cad_vendavnd_data: TWideStringField
      DisplayLabel = 'Data'
      FieldName = 'vnd_data'
      Size = 10
    end
  end
  object qry_pesq_venda: TADOQuery
    Connection = Conexao
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT vnd_cod, cli_cod, fun_cod, vnd_data FROM VENDAS')
    Left = 616
    Top = 104
    object qry_pesq_vendavnd_cod: TAutoIncField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'vnd_cod'
      ReadOnly = True
    end
    object qry_pesq_vendacli_cod: TIntegerField
      DisplayLabel = 'Cliente'
      FieldName = 'cli_cod'
    end
    object qry_pesq_vendafun_cod: TIntegerField
      DisplayLabel = 'Funcion'#225'rio'
      FieldName = 'fun_cod'
    end
    object qry_pesq_vendavnd_data: TWideStringField
      DisplayLabel = 'Data'
      FieldName = 'vnd_data'
      Size = 10
    end
  end
  object qry_cad_vnd_prod: TADOQuery
    Connection = Conexao
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      
        'SELECT vnd_cod, prod_cod, vnd_prod_qtd, vnd_prod_valor FROM VEND' +
        'A_PRODUTOS')
    Left = 616
    Top = 176
    object qry_cad_vnd_prodvnd_cod: TIntegerField
      DisplayLabel = 'Venda'
      FieldName = 'vnd_cod'
    end
    object qry_cad_vnd_prodprod_cod: TIntegerField
      DisplayLabel = 'Produto'
      FieldName = 'prod_cod'
    end
    object qry_cad_vnd_prodvnd_prod_qtd: TIntegerField
      DisplayLabel = 'Qtd.'
      FieldName = 'vnd_prod_qtd'
    end
    object qry_cad_vnd_prodvnd_prod_valor: TBCDField
      DisplayLabel = 'Valor'
      FieldName = 'vnd_prod_valor'
      Precision = 8
      Size = 2
    end
  end
  object qry_cad_compra: TADOQuery
    Connection = Conexao
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT comp_cod, comp_data, forn_cod FROM COMPRAS')
    Left = 736
    Top = 32
    object qry_cad_compracomp_cod: TAutoIncField
      DisplayLabel = 'Compra'
      FieldName = 'comp_cod'
      ReadOnly = True
    end
    object qry_cad_compracomp_data: TWideStringField
      DisplayLabel = 'Data'
      FieldName = 'comp_data'
      Size = 10
    end
    object qry_cad_compraforn_cod: TIntegerField
      DisplayLabel = 'Fornecedor'
      FieldName = 'forn_cod'
    end
  end
  object qry_cad_comp_prod: TADOQuery
    Connection = Conexao
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      
        'SELECT comp_cod, prod_cod, cmp_prd_qtd, cmp_prd_valor FROM COMPR' +
        'A_PRODUTOS')
    Left = 736
    Top = 176
    object qry_cad_comp_prodcomp_cod: TIntegerField
      DisplayLabel = 'Compra'
      FieldName = 'comp_cod'
    end
    object qry_cad_comp_prodprod_cod: TIntegerField
      DisplayLabel = 'Produto'
      FieldName = 'prod_cod'
    end
    object qry_cad_comp_prodcmp_prd_qtd: TIntegerField
      DisplayLabel = 'Qtd.'
      FieldName = 'cmp_prd_qtd'
    end
    object qry_cad_comp_prodcmp_prd_valor: TBCDField
      DisplayLabel = 'Valor'
      FieldName = 'cmp_prd_valor'
      Precision = 8
      Size = 2
    end
  end
  object qry_pesq_compra: TADOQuery
    Connection = Conexao
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT comp_cod, comp_data, forn_cod FROM COMPRAS')
    Left = 736
    Top = 104
    object qry_pesq_compracomp_cod: TAutoIncField
      DisplayLabel = 'Compra'
      FieldName = 'comp_cod'
      ReadOnly = True
    end
    object qry_pesq_compracomp_data: TWideStringField
      DisplayLabel = 'Data'
      FieldName = 'comp_data'
      Size = 10
    end
    object qry_pesq_compraforn_cod: TIntegerField
      DisplayLabel = 'Fornecedor'
      FieldName = 'forn_cod'
    end
  end
  object qry_lista_vnd_prod: TADOQuery
    Connection = Conexao
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      
        'SELECT vnd_cod, prod_cod, vnd_prod_qtd, vnd_prod_valor FROM VEND' +
        'A_PRODUTOS')
    Left = 616
    Top = 256
    object qry_lista_vnd_prodvnd_cod: TIntegerField
      DisplayLabel = 'Venda'
      FieldName = 'vnd_cod'
    end
    object qry_lista_vnd_prodprod_cod: TIntegerField
      DisplayLabel = 'Produto'
      FieldName = 'prod_cod'
    end
    object qry_lista_vnd_prodvnd_prod_qtd: TIntegerField
      DisplayLabel = 'Qtd.'
      FieldName = 'vnd_prod_qtd'
    end
    object qry_lista_vnd_prodvnd_prod_valor: TBCDField
      DisplayLabel = 'Valor'
      FieldName = 'vnd_prod_valor'
      Precision = 8
      Size = 2
    end
  end
  object qry_cad_forn_prod: TADOQuery
    Connection = Conexao
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      
        'SELECT forn_cod, prod_cod, frn_prd_valor FROM FORNECEDOR_PRODUTO' +
        'S')
    Left = 736
    Top = 328
    object qry_cad_forn_prodforn_cod: TIntegerField
      DisplayLabel = 'Fornecedor'
      FieldName = 'forn_cod'
    end
    object qry_cad_forn_prodprod_cod: TIntegerField
      DisplayLabel = 'Produto'
      FieldName = 'prod_cod'
    end
    object qry_cad_forn_prodfrn_prd_valor: TBCDField
      DisplayLabel = 'Valor'
      FieldName = 'frn_prd_valor'
      Precision = 8
      Size = 2
    end
  end
  object qry_lista_forn_prod: TADOQuery
    Connection = Conexao
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      
        'SELECT forn_cod, prod_cod, frn_prd_valor FROM FORNECEDOR_PRODUTO' +
        'S')
    Left = 136
    Top = 329
    object qry_lista_forn_prodforn_cod: TIntegerField
      DisplayLabel = 'Fornecedor'
      FieldName = 'forn_cod'
    end
    object qry_lista_forn_prodprod_cod: TIntegerField
      DisplayLabel = 'Produto'
      FieldName = 'prod_cod'
    end
    object qry_lista_forn_prodfrn_prd_valor: TBCDField
      DisplayLabel = 'Valor'
      FieldName = 'frn_prd_valor'
      Precision = 8
      Size = 2
    end
  end
  object qry_exibe_comp_prod: TADOQuery
    Connection = Conexao
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      
        'SELECT comp_cod, prod_cod, cmp_prd_qtd, cmp_prd_valor FROM COMPR' +
        'A_PRODUTOS')
    Left = 736
    Top = 256
    object qry_exibe_comp_prodcomp_cod: TIntegerField
      DisplayLabel = 'Compra'
      FieldName = 'comp_cod'
    end
    object qry_exibe_comp_prodprod_cod: TIntegerField
      DisplayLabel = 'Produto'
      FieldName = 'prod_cod'
    end
    object qry_exibe_comp_prodcmp_prd_qtd: TIntegerField
      DisplayLabel = 'Qtd.'
      FieldName = 'cmp_prd_qtd'
    end
    object qry_exibe_comp_prodcmp_prd_valor: TBCDField
      DisplayLabel = 'Valor'
      FieldName = 'cmp_prd_valor'
      Precision = 8
      Size = 2
    end
  end
  object qry_total: TADOQuery
    Connection = Conexao
    Parameters = <>
    Left = 32
    Top = 328
  end
end
