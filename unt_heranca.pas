unit unt_heranca;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.ComCtrls, Vcl.StdCtrls,
  Vcl.Buttons, Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls;

type
  Tfrm_heranca = class(TForm)
    pgc_heranca: TPageControl;
    tbs_cadastro: TTabSheet;
    tbs_pesquisa: TTabSheet;
    ds_dados: TDataSource;
    btn_adicionar: TBitBtn;
    btn_editar: TBitBtn;
    btn_salvar: TBitBtn;
    btn_excluir: TBitBtn;
    btn_cancelar: TBitBtn;
    pnl_info_pesquisa: TPanel;
    edt_pesquisa: TEdit;
    btn_pesquisa: TBitBtn;
    rbt_codigo: TRadioButton;
    rbt_nome: TRadioButton;
    dbg_pesquisa: TDBGrid;
    procedure btn_adicionarClick(Sender: TObject);
    procedure btn_editarClick(Sender: TObject);
    procedure btn_salvarClick(Sender: TObject);
    procedure btn_excluirClick(Sender: TObject);
    procedure btn_cancelarClick(Sender: TObject);
    procedure ds_dadosStateChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frm_heranca: Tfrm_heranca;

implementation

{$R *.dfm}

procedure Tfrm_heranca.btn_adicionarClick(Sender: TObject);
begin
  ds_dados.DataSet.Append;
end;

procedure Tfrm_heranca.btn_cancelarClick(Sender: TObject);
begin
  ds_dados.DataSet.Cancel;
end;

procedure Tfrm_heranca.btn_editarClick(Sender: TObject);
begin
  ds_dados.DataSet.Edit;
end;

procedure Tfrm_heranca.btn_excluirClick(Sender: TObject);
begin
  if MessageBox(Application.Handle, 'Você deseja exlcuir o registro?',
                'Excluir', 36) = IDYES then
  begin
    ds_dados.DataSet.Delete;
  end;
end;

procedure Tfrm_heranca.btn_salvarClick(Sender: TObject);
begin
  ds_dados.DataSet.Post;
end;

procedure Tfrm_heranca.ds_dadosStateChange(Sender: TObject);
begin
  btn_adicionar.Enabled := ds_dados.State = dsBrowse;
  btn_editar.Enabled := ds_dados.State = dsBrowse;
  btn_excluir.Enabled := ds_dados.State = dsBrowse;
  btn_salvar.Enabled := ds_dados.State in [dsInsert, dsEdit];
  btn_cancelar.Enabled := ds_dados.State in [dsInsert, dsEdit];
end;

end.
