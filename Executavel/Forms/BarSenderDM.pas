unit BarSenderDM;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FBDef,
  FireDAC.VCLUI.Wait, FireDAC.Comp.UI, FireDAC.Phys.IBBase, FireDAC.Phys.FB,
  Data.DB, FireDAC.Comp.Client, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.DataSet, Vcl.Dialogs,
  Vcl.Forms, System.UITypes, Winapi.Windows, Datasnap.DBClient, inifiles;

type
  TfrmBarSenderDM = class(TDataModule)
    dbConect: TFDConnection;
    fbDriver: TFDPhysFBDriverLink;
    fdCursorWait: TFDGUIxWaitCursor;
    qryContatos: TFDQuery;
    dsContatos: TDataSource;
    qryContatosNOME_CONTATO: TStringField;
    qryContatosNUMERO_CONTATO: TStringField;
    qryContatosMARCADO: TSmallintField;
    qryConfiguracao: TFDQuery;
    dsConfiguracao: TDataSource;
    qryConfiguracaoUSU_NOME: TStringField;
    qryConfiguracaoUSU_NUMERO: TStringField;
    qryConfiguracaoUSU_TOKEN: TStringField;
    DelContatos: TFDQuery;
    StringField1: TStringField;
    StringField2: TStringField;
    StringField3: TStringField;
    qryConfiguracaoMENSAGEM_PADRAO: TStringField;
    qryConfiguracaoDATA_VALIDACAO: TDateField;
    procedure DataModuleCreate(Sender: TObject);
    procedure qryContatosNewRecord(DataSet: TDataSet);
    procedure DelContatosBeforeExecute(DataSet: TFDDataSet);
  private
    { Private declarations }
  public
   sCaminhoApp : String;
   ArqConfiguracoes : TIniFile;
   procedure CriaQry( oQry : TfdQuery );
    { Public declarations }
  end;

var
  frmBarSenderDM: TfrmBarSenderDM;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TfrmBarSenderDM.CriaQry( oQry : TfdQuery );
begin
  oqry := oqry.Create(Self);
  oqry.Connection := dbConect;
  oqry.Connection.Connected;
end;

procedure TfrmBarSenderDM.DataModuleCreate(Sender: TObject);
begin
  sCaminhoApp := ExtractFilePath( ParamStr(0) );

  ArqConfiguracoes := TIniFile.Create( sCaminhoApp + 'Configuracao.ini');

  fbDriver.VendorLib := sCaminhoApp + 'BPL\fbclient.dll';

  dbConect.Params.UserName := 'SYSDBA';
  dbConect.Params.Password := 'masterkey';
  dbConect.Params.Database := ArqConfiguracoes.ReadString( 'Configuracao','CaminhoBD', 'Erro ao ler o arquivo' ) //sCaminhoApp + 'BARSENDER.FDB';

end;

procedure TfrmBarSenderDM.DelContatosBeforeExecute(DataSet: TFDDataSet);
begin
 if ( Application.MessageBox( 'Deseja Apagar o Registro selecionado ?', 'AVISO', MB_ICONEXCLAMATION+1  ) ) = IDCANCEL then
 abort
end;

procedure TfrmBarSenderDM.qryContatosNewRecord(DataSet: TDataSet);
begin
  qryContatosMARCADO.AsInteger := 0;
end;

end.
