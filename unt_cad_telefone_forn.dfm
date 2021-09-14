object frm_cad_telefone_forn: Tfrm_cad_telefone_forn
  Left = 0
  Top = 0
  ActiveControl = dbe_contato
  BorderStyle = bsNone
  BorderWidth = 15
  Caption = 'Cadastro de telefone'
  ClientHeight = 228
  ClientWidth = 601
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -19
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 23
  object lbl_contato: TLabel
    Left = 16
    Top = 8
    Width = 64
    Height = 23
    Caption = 'Contato'
  end
  object lbl_tipo: TLabel
    Left = 320
    Top = 8
    Width = 36
    Height = 23
    Caption = 'Tipo'
  end
  object btn_num: TLabel
    Left = 16
    Top = 88
    Width = 67
    Height = 23
    Caption = 'N'#250'mero'
  end
  object lbl_operadora: TLabel
    Left = 320
    Top = 88
    Width = 89
    Height = 23
    Caption = 'Operadora'
  end
  object dbe_contato: TDBEdit
    Left = 8
    Top = 37
    Width = 260
    Height = 31
    DataField = 'forn_tel_contato'
    DataSource = ds_cad_tel_forn
    TabOrder = 0
  end
  object dbc_tipo: TDBComboBox
    Left = 320
    Top = 37
    Width = 260
    Height = 31
    Style = csDropDownList
    DataField = 'forn_tel_tipo'
    DataSource = ds_cad_tel_forn
    Items.Strings = (
      'Fixo'
      'Fixo Recado'
      'Fax'
      'Celular'
      'Celular Recado')
    TabOrder = 1
    OnChange = dbc_tipoChange
  end
  object dbc_operadora: TDBComboBox
    Left = 320
    Top = 128
    Width = 260
    Height = 31
    Style = csDropDownList
    DataField = 'forn_tel_operadora'
    DataSource = ds_cad_tel_forn
    Items.Strings = (
      'Vivo'
      'Claro'
      'Tim'
      'Oi'
      'Nextel')
    TabOrder = 2
  end
  object msk_num: TMaskEdit
    Left = 8
    Top = 128
    Width = 260
    Height = 31
    TabOrder = 3
    Text = ''
  end
  object btn_gravar: TBitBtn
    Left = 320
    Top = 184
    Width = 120
    Height = 36
    Caption = 'OK'
    Default = True
    Glyph.Data = {
      DE010000424DDE01000000000000760000002800000024000000120000000100
      0400000000006801000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      3333333333333333333333330000333333333333333333333333F33333333333
      00003333344333333333333333388F3333333333000033334224333333333333
      338338F3333333330000333422224333333333333833338F3333333300003342
      222224333333333383333338F3333333000034222A22224333333338F338F333
      8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
      33333338F83338F338F33333000033A33333A222433333338333338F338F3333
      0000333333333A222433333333333338F338F33300003333333333A222433333
      333333338F338F33000033333333333A222433333333333338F338F300003333
      33333333A222433333333333338F338F00003333333333333A22433333333333
      3338F38F000033333333333333A223333333333333338F830000333333333333
      333A333333333333333338330000333333333333333333333333333333333333
      0000}
    NumGlyphs = 2
    TabOrder = 4
    OnClick = btn_gravarClick
  end
  object btn_cancelar: TBitBtn
    Left = 460
    Top = 184
    Width = 120
    Height = 36
    Cancel = True
    Caption = 'Cancelar'
    Glyph.Data = {
      DE010000424DDE01000000000000760000002800000024000000120000000100
      0400000000006801000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      333333333333333333333333000033338833333333333333333F333333333333
      0000333911833333983333333388F333333F3333000033391118333911833333
      38F38F333F88F33300003339111183911118333338F338F3F8338F3300003333
      911118111118333338F3338F833338F3000033333911111111833333338F3338
      3333F8330000333333911111183333333338F333333F83330000333333311111
      8333333333338F3333383333000033333339111183333333333338F333833333
      00003333339111118333333333333833338F3333000033333911181118333333
      33338333338F333300003333911183911183333333383338F338F33300003333
      9118333911183333338F33838F338F33000033333913333391113333338FF833
      38F338F300003333333333333919333333388333338FFF830000333333333333
      3333333333333333333888330000333333333333333333333333333333333333
      0000}
    NumGlyphs = 2
    TabOrder = 5
    OnClick = btn_cancelarClick
  end
  object ds_cad_tel_forn: TDataSource
    AutoEdit = False
    DataSet = DM.qry_cad_forn_tel
    Left = 152
    Top = 176
  end
end
