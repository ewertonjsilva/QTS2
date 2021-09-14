unit UDM;

interface

uses
  System.SysUtils, System.Classes, Data.DB, Data.Win.ADODB;

type
  TDM = class(TDataModule)
    Conexao: TADOConnection;
    qry_cad_cliente: TADOQuery;
    qry_cad_fornecedor: TADOQuery;
    qry_cad_funcionario: TADOQuery;
    qry_pesq_fornecedor: TADOQuery;
    qry_cad_produto: TADOQuery;
    qry_pesq_cliente: TADOQuery;
    qry_pesq_funcionario: TADOQuery;
    qry_pesq_produto: TADOQuery;
    qry_cad_forn_endereco: TADOQuery;
    qry_cad_cli_endereco: TADOQuery;
    qry_cad_forn_tel: TADOQuery;
    qry_cad_cli_tel: TADOQuery;
    qry_cad_venda: TADOQuery;
    qry_pesq_venda: TADOQuery;
    qry_cad_vnd_prod: TADOQuery;
    qry_cad_compra: TADOQuery;
    qry_cad_comp_prod: TADOQuery;
    qry_pesq_compra: TADOQuery;
    qry_lista_vnd_prod: TADOQuery;
    qry_cad_forn_prod: TADOQuery;
    qry_lista_forn_prod: TADOQuery;
    qry_exibe_comp_prod: TADOQuery;
    qry_cad_cli_enderecocli_cod: TIntegerField;
    qry_cad_cli_enderecocli_end_cep: TStringField;
    qry_cad_cli_enderecocli_end_logradouro: TStringField;
    qry_cad_cli_enderecocli_end_complemento: TStringField;
    qry_cad_cli_enderecocli_end_bairro: TStringField;
    qry_cad_cli_enderecocli_end_localizacao: TStringField;
    qry_cad_cli_enderecocli_end_uf: TStringField;
    qry_cad_cli_enderecocli_end_numero: TStringField;
    qry_cad_cli_enderecocli_end_referencia: TStringField;
    qry_cad_cli_telcli_tel_cod: TAutoIncField;
    qry_cad_cli_telcli_tel_contato: TStringField;
    qry_cad_cli_telcli_tel_tipo: TStringField;
    qry_cad_cli_telcli_tel_numero: TStringField;
    qry_cad_cli_telcli_tel_operadora: TStringField;
    qry_cad_cli_telcli_cod: TIntegerField;
    qry_cad_clientecli_cod: TAutoIncField;
    qry_cad_clientecli_nome: TStringField;
    qry_cad_clientecli_cpf: TStringField;
    qry_cad_clientecli_renda: TBCDField;
    qry_cad_clientecli_ativo: TBooleanField;
    qry_cad_clientecli_dt_nasc: TWideStringField;
    qry_cad_clientecli_img: TStringField;
    qry_cad_clientecli_email: TStringField;
    qry_pesq_clientecli_cod: TAutoIncField;
    qry_pesq_clientecli_nome: TStringField;
    qry_pesq_clientecli_cpf: TStringField;
    qry_pesq_clientecli_renda: TBCDField;
    qry_pesq_clientecli_ativo: TBooleanField;
    qry_pesq_clientecli_dt_nasc: TWideStringField;
    qry_pesq_clientecli_img: TStringField;
    qry_pesq_clientecli_email: TStringField;
    qry_cad_comp_prodcomp_cod: TIntegerField;
    qry_cad_comp_prodprod_cod: TIntegerField;
    qry_cad_comp_prodcmp_prd_qtd: TIntegerField;
    qry_cad_comp_prodcmp_prd_valor: TBCDField;
    qry_exibe_comp_prodcomp_cod: TIntegerField;
    qry_exibe_comp_prodprod_cod: TIntegerField;
    qry_exibe_comp_prodcmp_prd_qtd: TIntegerField;
    qry_exibe_comp_prodcmp_prd_valor: TBCDField;
    qry_cad_compracomp_cod: TAutoIncField;
    qry_cad_compracomp_data: TWideStringField;
    qry_cad_compraforn_cod: TIntegerField;
    qry_pesq_compracomp_cod: TAutoIncField;
    qry_pesq_compracomp_data: TWideStringField;
    qry_pesq_compraforn_cod: TIntegerField;
    qry_cad_forn_enderecoforn_cod: TIntegerField;
    qry_cad_forn_enderecofor_end_cep: TStringField;
    qry_cad_forn_enderecofor_end_logradouro: TStringField;
    qry_cad_forn_enderecofor_end_complemento: TStringField;
    qry_cad_forn_enderecofor_end_bairro: TStringField;
    qry_cad_forn_enderecofor_end_localizacao: TStringField;
    qry_cad_forn_enderecofor_end_uf: TStringField;
    qry_cad_forn_enderecofor_end_numero: TStringField;
    qry_cad_forn_enderecofor_end_referencia: TStringField;
    qry_cad_forn_prodforn_cod: TIntegerField;
    qry_cad_forn_prodprod_cod: TIntegerField;
    qry_cad_forn_prodfrn_prd_valor: TBCDField;
    qry_lista_forn_prodforn_cod: TIntegerField;
    qry_lista_forn_prodprod_cod: TIntegerField;
    qry_lista_forn_prodfrn_prd_valor: TBCDField;
    qry_cad_forn_telforn_tel_cod: TAutoIncField;
    qry_cad_forn_telforn_tel_contato: TStringField;
    qry_cad_forn_telforn_tel_tipo: TStringField;
    qry_cad_forn_telforn_tel_numero: TStringField;
    qry_cad_forn_telforn_tel_operadora: TStringField;
    qry_cad_forn_telforn_cod: TIntegerField;
    qry_cad_fornecedorforn_cod: TAutoIncField;
    qry_cad_fornecedorforn_nm_fantasia: TStringField;
    qry_cad_fornecedorforn_razao_social: TStringField;
    qry_cad_fornecedorforn_dt_cad: TWideStringField;
    qry_cad_fornecedorforn_cnpj: TStringField;
    qry_cad_fornecedorforn_ativo: TBooleanField;
    qry_cad_fornecedorforn_img: TStringField;
    qry_cad_fornecedorforn_observacoes: TStringField;
    qry_pesq_fornecedorforn_cod: TAutoIncField;
    qry_pesq_fornecedorforn_nm_fantasia: TStringField;
    qry_pesq_fornecedorforn_razao_social: TStringField;
    qry_pesq_fornecedorforn_dt_cad: TWideStringField;
    qry_pesq_fornecedorforn_cnpj: TStringField;
    qry_pesq_fornecedorforn_ativo: TBooleanField;
    qry_pesq_fornecedorforn_img: TStringField;
    qry_pesq_fornecedorforn_observacoes: TStringField;
    qry_cad_funcionariofun_cod: TAutoIncField;
    qry_cad_funcionariofun_nome: TStringField;
    qry_cad_funcionariofun_dt_nasc: TWideStringField;
    qry_cad_funcionariofun_salario: TBCDField;
    qry_cad_funcionariofun_login: TStringField;
    qry_cad_funcionariofun_senha: TStringField;
    qry_cad_funcionariofun_tp_usu: TStringField;
    qry_pesq_funcionariofun_cod: TAutoIncField;
    qry_pesq_funcionariofun_nome: TStringField;
    qry_pesq_funcionariofun_dt_nasc: TWideStringField;
    qry_pesq_funcionariofun_salario: TBCDField;
    qry_pesq_funcionariofun_login: TStringField;
    qry_pesq_funcionariofun_senha: TStringField;
    qry_pesq_funcionariofun_tp_usu: TStringField;
    qry_cad_produtoprod_cod: TAutoIncField;
    qry_cad_produtoprod_nome: TStringField;
    qry_cad_produtoprod_img: TStringField;
    qry_cad_produtoprod_estq: TIntegerField;
    qry_cad_produtoprod_vlr_comp: TBCDField;
    qry_cad_produtoprod_vlr_vnd: TBCDField;
    qry_cad_produtoprod_lucro: TIntegerField;
    qry_pesq_produtoprod_cod: TAutoIncField;
    qry_pesq_produtoprod_nome: TStringField;
    qry_pesq_produtoprod_img: TStringField;
    qry_pesq_produtoprod_estq: TIntegerField;
    qry_pesq_produtoprod_vlr_comp: TBCDField;
    qry_pesq_produtoprod_vlr_vnd: TBCDField;
    qry_pesq_produtoprod_lucro: TIntegerField;
    qry_cad_vnd_prodvnd_cod: TIntegerField;
    qry_cad_vnd_prodprod_cod: TIntegerField;
    qry_cad_vnd_prodvnd_prod_qtd: TIntegerField;
    qry_cad_vnd_prodvnd_prod_valor: TBCDField;
    qry_lista_vnd_prodvnd_cod: TIntegerField;
    qry_lista_vnd_prodprod_cod: TIntegerField;
    qry_lista_vnd_prodvnd_prod_qtd: TIntegerField;
    qry_lista_vnd_prodvnd_prod_valor: TBCDField;
    qry_cad_vendavnd_cod: TAutoIncField;
    qry_cad_vendacli_cod: TIntegerField;
    qry_cad_vendafun_cod: TIntegerField;
    qry_cad_vendavnd_data: TWideStringField;
    qry_pesq_vendavnd_cod: TAutoIncField;
    qry_pesq_vendacli_cod: TIntegerField;
    qry_pesq_vendafun_cod: TIntegerField;
    qry_pesq_vendavnd_data: TWideStringField;
    qry_total: TADOQuery;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DM: TDM;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}



{$R *.dfm}

end.
