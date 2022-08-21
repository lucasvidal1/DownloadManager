unit DownloadManagerApp.Controller.Download;

interface

uses
  DownloadManagerApp.Controller.Interfaces, DownloadManagerApp.Util.Download,
  Vcl.ComCtrls, IdComponent, System.Threading,
  DownloadManagerApp.Controller.Entidades;

type
  TDownload = class(TInterfacedObject, iControllerDownload)
  private
    FIdHTTPProgress: TIdHTTPProgress;
    FProgress: TProgressBar;
    FUrl: String;
    FCaminhoArquivo: String;
    FController: iControllerEntidades;
    FCodigo: Integer;

    procedure ProgressOnChange(ASender: TObject);
    procedure WorkEnd(ASender: TObject; AWorkMode: TWorkMode);
    procedure WorkEndCancelado(ASender: TObject; AWorkMode: TWorkMode);
  public
    constructor Create(Progress: TProgressBar);
    Destructor Destroy; override;
    class function New(Progress: TProgressBar): iControllerDownload;

    function SetUrl(Value: String): iControllerDownload;
    function SetCaminhoArquivo(Value: String): iControllerDownload;
    function GetProgressoDownload: String;
    function GetDownloadEmAndamento: Boolean;
    procedure SetInicioDownload;
    procedure SetFimDownload;
    procedure IniciarDownload;
    procedure CancelarDownload;
  end;

implementation

uses
  Vcl.Dialogs, System.SysUtils;

{ TDownload }

procedure TDownload.CancelarDownload;
begin
  FIdHTTPProgress.OnWorkEnd := WorkEndCancelado;
  FIdHTTPProgress.Disconnect(False);
end;

constructor TDownload.Create(Progress: TProgressBar);
begin
  FIdHTTPProgress := TIdHTTPProgress.Create(nil);
  FController := TControllerEntidades.New;
  FProgress := Progress;
end;

destructor TDownload.Destroy;
begin
  FIdHTTPProgress.Free;

  inherited;
end;

function TDownload.GetDownloadEmAndamento: Boolean;
begin
  Result := FIdHTTPProgress.BytesToTransfer > 0;
end;

function TDownload.GetProgressoDownload: String;
begin
  Result := IntToStr(FProgress.Position);
end;

procedure TDownload.IniciarDownload;
begin
  FIdHTTPProgress.OnChange := ProgressOnChange;
  FIdHTTPProgress.OnWorkEnd := WorkEnd;

  SetInicioDownload;

  FIdHTTPProgress.DownloadFile(FUrl, FCaminhoArquivo);
end;

class function TDownload.New(Progress: TProgressBar): iControllerDownload;
begin
  Result := Self.Create(Progress);
end;

procedure TDownload.ProgressOnChange(ASender: TObject);
begin
  FProgress.Position := TIdHTTPProgress(ASender).Progress;
end;

function TDownload.SetCaminhoArquivo(Value: String): iControllerDownload;
begin
  Result := Self;

  FCaminhoArquivo := Value;
end;

procedure TDownload.SetFimDownload;
var
  vSQL: String;
begin
  vSQL := 'UPDATE LOGDOWNLOAD SET DATAFIM = DateTime("Now")';
  vSQL := vSQL + ' WHERE CODIGO = ' + IntToStr(FCodigo);

  FController.Entidades.Historico.ExecSQL(vSQL);
end;

procedure TDownload.SetInicioDownload;
var
  vSQL: String;
begin
  vSQL := 'INSERT INTO LOGDOWNLOAD (URL, DATAINICIO) ';
  vSQL := vSQL + 'VALUES ("' + FUrl + '", DateTime("Now")); ';
  vSQL := vSQL + 'SELECT LAST_INSERT_AUTOGEN() AS CODIGO ';

  FCodigo := FController.Entidades.Historico.ExecSQLReturning(vSQL);
end;

function TDownload.SetUrl(Value: String): iControllerDownload;
begin
  Result := Self;

  FUrl := Value;
end;

procedure TDownload.WorkEnd(ASender: TObject; AWorkMode: TWorkMode);
begin
  FIdHTTPProgress.BytesToTransfer := 0;
  FProgress.Position := 100;

  SetFimDownload;
end;

procedure TDownload.WorkEndCancelado(ASender: TObject; AWorkMode: TWorkMode);
begin
  FIdHTTPProgress.BytesToTransfer := 0;
  FProgress.Position := 0;

  SetFimDownload;
end;

end.
