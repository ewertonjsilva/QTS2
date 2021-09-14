unit unt_modelo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls,
  Vcl.DBCtrls;

type
  Tfrm_modelo = class(TForm)
    dbn_cad_forn: TDBNavigator;
    btn_castrar: TBitBtn;
    btn_editar: TBitBtn;
    btn_salvar: TBitBtn;
    btn_cancelar: TBitBtn;
    btn_excluir: TBitBtn;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frm_modelo: Tfrm_modelo;

implementation

{$R *.dfm}

end.
