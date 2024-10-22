unit BarSender;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, dxSkinsCore, dxSkinsDefaultPainters,
  dxBarBuiltInMenu, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, Vcl.Menus, cxContainer, cxEdit, cxStyles, cxCustomData,
  cxFilter, cxData, cxDataStorage, cxNavigator, dxDateRanges, Data.DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, dxGDIPlusClasses, Vcl.ExtCtrls,
  cxLabel, Vcl.StdCtrls, cxButtons, cxPC, cxTextEdit, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.VCLUI.Wait, FireDAC.Comp.Client, BarSenderDM, cxCheckBox, Vcl.Mask,
  Vcl.DBCtrls, cxGroupBox, RxToolEdit, REST.Types, REST.Client,
  Data.Bind.Components, Data.Bind.ObjectScope, System.Net.URLClient,
  System.Net.HttpClient, System.Net.HttpClientComponent, System.NetEncoding,
  ACBrGIF, Vcl.ComCtrls, Vcl.Grids, uImportExcel, System.Actions, Vcl.ActnList,
  dxCore, cxDateUtils, cxMaskEdit, cxDropDownEdit, cxCalendar, RxDBCtrl, inifiles;

type
  TfrmBarSender = class(TForm)
    PageEnvios: TcxPageControl;
    TabSelecao: TcxTabSheet;
    TabEnvio: TcxTabSheet;
    Panel1: TPanel;
    Panel2: TPanel;
    btnClose: TcxButton;
    cxLabel1: TcxLabel;
    Image1: TImage;
    grdContatosDBTableView1: TcxGridDBTableView;
    grdContatosLevel1: TcxGridLevel;
    grdContatos: TcxGrid;
    PagePrincipal: TcxPageControl;
    TabEnviar: TcxTabSheet;
    TabCadastrar: TcxTabSheet;
    edtNomeContato: TcxTextEdit;
    Panel3: TPanel;
    btnAvancar: TcxButton;
    btnVoltar: TcxButton;
    Label1: TLabel;
    Label2: TLabel;
    edtNumero: TcxTextEdit;
    edtDDD: TcxTextEdit;
    cxButton1: TcxButton;
    grdContatosDBTableView1Column1: TcxGridDBColumn;
    grdContatosDBTableViewContato: TcxGridDBColumn;
    grdContatosDBTableViewNumero: TcxGridDBColumn;
    tabConfigura��o: TcxTabSheet;
    cxLabel2: TcxLabel;
    cxLabel3: TcxLabel;
    cxLabel4: TcxLabel;
    edtConfNumero: TDBEdit;
    edtConfToken: TDBEdit;
    edtConfUsuario: TDBEdit;
    btnSaveConfig: TcxButton;
    pnlButtons: TPanel;
    btnEdtConfig: TcxButton;
    pnlConfigMsg: TcxGroupBox;
    edtMemoMsg: TMemo;
    edtARQ_PATH: TFilenameEdit;
    Label3: TLabel;
    btnEnviar: TcxButton;
    PopupGRID: TPopupMenu;
    ApagarRegistro1: TMenuItem;
    TabImportar: TcxTabSheet;
    cxLabel5: TcxLabel;
    cxLabel6: TcxLabel;
    btnExportar: TcxButton;
    ImportExcel: TImportExcel;
    GridExcel: TStringGrid;
    BarraExcel: TProgressBar;
    edtPathExcel: TEdit;
    btnPathExcel: TcxButton;
    OpenDialog: TOpenDialog;
    ActionList: TActionList;
    HabilitaVerificacao: TAction;
    tabVerificacao: TcxTabSheet;
    cxLabel7: TcxLabel;
    cxButton2: TcxButton;
    edtDataRenovacao: TcxDateEdit;
    procedure btnCloseClick(Sender: TObject);
    procedure Panel2MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure cxButton1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure btnEdtConfigClick(Sender: TObject);
    procedure btnSaveConfigClick(Sender: TObject);
    procedure grdContatosDBTableView1Column1PropertiesEditValueChanged(
      Sender: TObject);
    procedure tabConfigura��oHide(Sender: TObject);
    procedure PageEnviosChange(Sender: TObject);
    procedure btnAvancarClick(Sender: TObject);
    procedure btnVoltarClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure btnEnviarClick(Sender: TObject);
    procedure ApagarRegistro1Click(Sender: TObject);
    procedure edtARQ_PATHChange(Sender: TObject);
    procedure btnPathExcelClick(Sender: TObject);
    procedure btnExportarClick(Sender: TObject);
    procedure grdContatosDBTableView1Column1HeaderClick(Sender: TObject);
    procedure HabilitaVerificacaoExecute(Sender: TObject);
    procedure cxButton2Click(Sender: TObject);
  private
    procedure MarcaDesmarca;
    procedure LimpaEdits;
    procedure EnviarMsgWhatsApp( sAPIKEYEMP, sTelefoneFrom, sTelefoneTo : String; sMensagem : WideString = ''; sCaminhoAnexo : String = ''; lEviarMensagemPDF : Boolean = False );
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmBarSender: TfrmBarSender;

implementation

{$R *.dfm}

procedure TfrmBarSender.ApagarRegistro1Click(Sender: TObject);
begin
  frmBarSenderDM.DelContatos.Close;
  frmBarSenderDM.DelContatos.ParamByName( 'NOME_CONTATO'   ).AsString := frmBarSenderDM.qryContatosNOME_CONTATO.AsString;
  frmBarSenderDM.DelContatos.ParamByName( 'NUMERO_CONTATO' ).AsString := frmBarSenderDM.qryContatosNUMERO_CONTATO.AsString;
  frmBarSenderDM.DelContatos.ExecSQL;
  frmBarSenderDM.qryContatos.Refresh;
end;

procedure TfrmBarSender.btnAvancarClick(Sender: TObject);
begin
  if frmBarSenderDM.qryConfiguracaoDATA_VALIDACAO.AsDateTime <= now then
  begin
    showmessage( 'Voc� n�o pode continuar pois seu tempo limite foi expedido!' );
    abort
  end;
  PageEnvios.ActivePageIndex := 1;
end;

procedure TfrmBarSender.btnCloseClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TfrmBarSender.btnEdtConfigClick(Sender: TObject);
begin
  edtConfNumero.Enabled := true;
  edtConfUsuario.Enabled := true;
  edtConfToken.Enabled := true;
  btnSaveConfig.Enabled := true;
  btnEdtConfig.Enabled := false;
  frmBarSenderDM.qryConfiguracao.Edit;
end;

procedure TfrmBarSender.btnEnviarClick(Sender: TObject);
begin
  with frmBarSenderDM do
  begin
    try
      qryContatos.Filtered := False;
      qryContatos.Filter   := 'MARCADO = 1';
      qryContatos.Filtered := True;
      qryContatos.First;

      while not qryContatos.Eof do
      begin
        EnviarMsgWhatsApp( qryConfiguracaoUSU_TOKEN.AsString, qryConfiguracaoUSU_NUMERO.AsString, qryContatosNUMERO_CONTATO.AsString,
                           edtMemoMsg.Text, edtARQ_PATH.Text );
        qryContatos.Next;
      end;
    finally

      Application.MessageBox( 'Mensagens enviadas com sucesso!', 'AVISO', 0 );

      qryContatos.Filter   := '';
      qryContatos.Filtered := False;
    end;
  end;
end;

procedure TfrmBarSender.btnExportarClick(Sender: TObject);
var
  I: Integer;
begin
  with frmBarSenderDM do
  begin
    BarraExcel.Max := GridExcel.RowCount;
    BarraExcel.Position := 0;

    for I := 1 to Pred( GridExcel.RowCount ) do
    begin
      Application.ProcessMessages;
      BarraExcel.Position := BarraExcel.Position + 1;

      qryContatos.Insert;
      qryContatosNOME_CONTATO.AsString := GridExcel.Cells[0,I];
      qryContatosNUMERO_CONTATO.AsString  := GridExcel.Cells[1,I];
      qryContatos.Post;
    end;
  end;
  Application.MessageBox( 'Dados exportados com sucesso !', 'AVISO', 0 );
  BarraExcel.Position := 0;
end;

procedure TfrmBarSender.btnPathExcelClick(Sender: TObject);
begin
  if OpenDialog.Execute then
  begin
    edtPathExcel.Text := OpenDialog.FileName;

    if edtPathExcel.Text <> '' then
    begin
      ImportExcel.ExcelFile := edtPathExcel.Text;
      ImportExcel.ExcelParaStringGrid( GridExcel, BarraExcel );
    end
    else
    Application.MessageBox( 'Por favor, Preencha o campo cima com o caminho do Arquivo', 'AVISO!!!', 0 );
  end;
end;

procedure TfrmBarSender.btnSaveConfigClick(Sender: TObject);
begin
  with frmBarSenderDM do
  begin
    qryConfiguracaoUSU_NOME.AsString   := edtConfUsuario.Text;
    qryConfiguracaoUSU_NUMERO.AsString := edtConfNumero.Text;
    qryConfiguracaoUSU_TOKEN.AsString  := edtConfToken.Text;
    qryConfiguracao.Post;

    edtConfNumero.Enabled := False;
    edtConfUsuario.Enabled := False;
    edtConfToken.Enabled := False;
    btnSaveConfig.Enabled := False;
    btnEdtConfig.Enabled := True;
  end;
end;

procedure TfrmBarSender.btnVoltarClick(Sender: TObject);
begin
  PageEnvios.ActivePageIndex := 0;
end;

procedure TfrmBarSender.cxButton1Click(Sender: TObject);
begin
  if( edtNomeContato.Text <> '' ) or ( edtDDD.Text <> '' ) or ( edtNumero.Text <> '' ) then
  begin
    frmBarSenderDM.qryContatos.Append;
    frmBarSenderDM.qryContatosNOME_CONTATO.AsString := edtNomeContato.Text;
    frmBarSenderDM.qryContatosNUMERO_CONTATO.AsString := edtDDD.Text + edtNumero.Text;
    frmBarSenderDM.qryContatos.Post;
    LimpaEdits;
  end
  else
  Application.MessageBox( 'Para Salvar, Preencha Todos os Campos !', 'AVISO!!!', 0 );

end;

procedure TfrmBarSender.cxButton2Click(Sender: TObject);
begin
  if frmBarSenderDM.qryConfiguracao.State in dsEditModes then
    frmBarSenderDM.qryConfiguracaoDATA_VALIDACAO.AsDateTime := edtDataRenovacao.Date
  else
  begin
    frmBarSenderDM.qryConfiguracao.Edit;
    frmBarSenderDM.qryConfiguracaoDATA_VALIDACAO.AsDateTime := edtDataRenovacao.Date;
  end;

  frmBarSenderDM.qryConfiguracao.Post;
end;

procedure TfrmBarSender.edtARQ_PATHChange(Sender: TObject);
begin
  //edtARQ_PATH.Text := StringReplace( edtARQ_PATH.text, '"', '' , rfReplaceAll );
end;

procedure TfrmBarSender.FormActivate(Sender: TObject);
begin
  PagePrincipal.ActivePageIndex := 0;
  PageEnvios.ActivePageIndex := 0;
  edtMemoMsg.Text := '';
  edtDataRenovacao.Date := frmBarSenderDM.qryConfiguracaoDATA_VALIDACAO.AsDateTime;
end;

procedure TfrmBarSender.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  frmBarSenderDM.qryContatos.Close;
end;

Procedure TfrmBarSender.LimpaEdits;
begin
  edtNomeContato.Text := '';
  edtNumero.Text      := '';
  edtDDD.Text         := '';
end;

procedure TfrmBarSender.MarcaDesmarca;
var
  qryMarcaDesmarca : TFDQuery;
begin

  qryMarcaDesmarca := TFDQuery.Create(self);
  qryMarcaDesmarca.Connection := frmBarSenderDM.dbConect;

  with frmBarSenderDM do
  begin
    qryMarcaDesmarca.Close;
    qryMarcaDesmarca.SQL.Clear;
    qryMarcaDesmarca.Open( 'select * from contatos where marcado = 1 ' );
    if qryMarcaDesmarca.IsEmpty = true then
    begin
      qryMarcaDesmarca.Close;
      qryMarcaDesmarca.SQL.Clear;
      qryMarcaDesmarca.SQL.Add( 'update contatos set marcado = 1 ' );
      qryMarcaDesmarca.ExecSQL;
    end
    else
    begin
      qryMarcaDesmarca.Close;
      qryMarcaDesmarca.SQL.Clear;
      qryMarcaDesmarca.SQL.Add( 'update contatos set marcado = 0 ' );
      qryMarcaDesmarca.ExecSQL;
    end;

    qryContatos.Refresh;
  end;
end;

procedure TfrmBarSender.FormShow(Sender: TObject);
var
  aArquivoIni : TIniFile;
begin
  frmBarSenderDM.qryContatos.Open;
  frmBarSenderDM.qryConfiguracao.Open;
end;

procedure TfrmBarSender.grdContatosDBTableView1Column1HeaderClick(
  Sender: TObject);
begin
  MarcaDesmarca;
end;

procedure TfrmBarSender.grdContatosDBTableView1Column1PropertiesEditValueChanged(
  Sender: TObject);
begin
  frmBarSenderDM.qryContatos.Post;
end;

procedure TfrmBarSender.HabilitaVerificacaoExecute(Sender: TObject);
begin
  if tabVerificacao.tabVisible <> true then
    tabVerificacao.tabVisible := True
  else
    tabVerificacao.tabVisible := False;
end;

procedure TfrmBarSender.PageEnviosChange(Sender: TObject);
begin
  if PageEnvios.ActivePageIndex = 0 then
  begin
    btnEnviar.Visible  := false;
    btnAvancar.Visible := true;
  end
  else
  begin
    btnEnviar.Visible  := true;
    btnAvancar.Visible := false;
  end;

end;

procedure TfrmBarSender.Panel2MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
const
   sc_DragMove = $f012;
begin
  ReleaseCapture;
  Perform(wm_SysCommand, sc_DragMove, 0);
end;

procedure TfrmBarSender.tabConfigura��oHide(Sender: TObject);
begin
  if( frmBarSenderDM.qryConfiguracao.State in dsEditModes )then
  begin
    Application.MessageBox( 'Por Favor, Salve as altera��es feitas !', 'AVISO !', 0 );
    PagePrincipal.ActivePage := tabConfigura��o;
  end;
end;

procedure TfrmBarSender.EnviarMsgWhatsApp( sAPIKEYEMP, sTelefoneFrom, sTelefoneTo : String; sMensagem : WideString = ''; sCaminhoAnexo : String = ''; lEviarMensagemPDF : Boolean = False );
var
  inStream       : TStream;
  outStream      : TStream;
  StringList     : TStringList;
  sNomeArquivo   : String;
  sExtArquivo    : String;
  sURLBase       : String;
  sCaminhoBase64 : String;
  sRESTClient    : TRESTClient;
  sRESTRequest   : TRESTRequest;
  sRESTResponse  : TRESTResponse;

begin

  //sTelefoneFrom := StrSuprime( Trim( sTelefoneFrom ), ' <>:?,.;/^~{}[]"!@#$%�&*()_-+=|\QWERTYUIOPASDFGHJKL�ZXCVBNM' );
  //sTelefoneTo   := StrSuprime( Trim( sTelefoneTo ), ' <>:?,.;/^~{}[]"!@#$%�&*()_-+=|\QWERTYUIOPASDFGHJKL�ZXCVBNM' );

  if( Trim( sTelefoneFrom ) <> '' ) and
    ( Trim( sTelefoneTo ) <> ''   )then
  try

    sURLBase := 'https://app.whatsgw.com.br/api/WhatsGw/Send';

    sRESTClient   := TRESTClient.Create( sURLBase );
    sRESTRequest  := TRESTRequest.Create( sRESTClient );
    sRESTResponse := TRESTResponse.Create( sRESTClient );
    StringList    := TStringList.Create;

    if( Trim( sCaminhoAnexo ) <> '' )then
    begin

      sExtArquivo    := ExtractFileExt( sCaminhoAnexo );
      sCaminhoBase64 := ExtractFilePath( sCaminhoAnexo ) + ChangeFileExt( ExtractFileName( sCaminhoAnexo ), EmptyStr ) + '.txt';

      try

        inStream := TFileStream.Create( sCaminhoAnexo, fmOpenRead);

        try

          outStream := TFileStream.Create( sCaminhoBase64, fmCreate );

          TNetEncoding.Base64.Encode( inStream, outStream );

        finally

          FreeAndNil( outStream );

        end;

      finally

        FreeAndNil( inStream );

      end;

      sNomeArquivo := ChangeFileExt( ExtractFileName( sCaminhoAnexo ), EmptyStr );
      StringList.LoadFromFile( sCaminhoBase64 );

    end;

    //Parametros RestRequest
    sRESTRequest.Client   := sRESTClient;
    sRESTRequest.Response := sRESTResponse;
    sRESTRequest.Accept   := 'application/json;q=0.9,text/plain;q=0.9,text/html';
    sRESTRequest.Method   := rmPOST;

    //Parametros RestClient
    sRESTClient.AcceptCharset       := 'UTF-8';
    sRESTClient.Accept              := 'application/json;q=0.9,text/plain;q=0.9,text/html';
    sRESTClient.RaiseExceptionOn500 := False;
    sRESTRequest.Params.Clear;

    sRESTRequest.Params.Add;
    sRESTRequest.Params.Items[0].Name  := 'apikey';
    sRESTRequest.Params.Items[0].Value := sAPIKEYEMP;

    sRESTRequest.Params.Add;
    sRESTRequest.Params.Items[1].Name  := 'phone_number';
    sRESTRequest.Params.Items[1].Value := '55' + sTelefoneFrom;

    sRESTRequest.Params.Add;
    sRESTRequest.Params.Items[2].Name  := 'contact_phone_number';
    sRESTRequest.Params.Items[2].Value := '55' + sTelefoneTo;

    sRESTRequest.Params.Add;
    sRESTRequest.Params.Items[3].Name  := 'message_custom_id';
    sRESTRequest.Params.Items[3].Value := 'yowsoftwareid';

    sRESTRequest.Params.Add;
    sRESTRequest.Params.Items[4].Name  := 'message_type';

    if( Trim( sExtArquivo ) = '' )then
    begin
     sRESTRequest.Params.Items[4].Value := 'text';
     StringList.Text := sMensagem;
    end
    else
      sRESTRequest.Params.Items[4].Value := 'image';

    sRESTRequest.Params.Add;
    sRESTRequest.Params.Items[5].Name  := 'message_caption';
    sRESTRequest.Params.Items[5].Value := sMensagem;

    sRESTRequest.Params.Add;
    sRESTRequest.Params.Items[6].Name  := 'message_body_mimetype';
    sRESTRequest.Params.Items[6].Value := 'image/jpeg';

    sRESTRequest.Params.Add;
    sRESTRequest.Params.Items[7].Name  := 'message_body_filename';
    sRESTRequest.Params.Items[7].Value := sNomeArquivo + sExtArquivo;

    sRESTRequest.Params.Add;
    sRESTRequest.Params.Items[8].Name  := 'message_body';
    sRESTRequest.Params.Items[8].Value := StringList.Text;

    sRESTRequest.Execute;

  finally

    DeleteFile( sCaminhoBase64 );

    FreeAndNil( sRESTClient );
    FreeAndNil( StringList );

    if( lEviarMensagemPDF )then
      EnviarMsgWhatsApp( sAPIKEYEMP, sTelefoneFrom, sTelefoneTo, sMensagem );

  end;

end;

end.
