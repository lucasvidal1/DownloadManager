unit DownloadManagerApp.Util.Download;

interface

uses
  Classes, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdHTTP,
  IdSSLOpenSSL;

{$M+}

type
  TIdHTTPProgress = class(TIdHTTP)
  private
    FProgress: Integer;
    FBytesToTransfer: Int64;
    FOnChange: TNotifyEvent;
    IOHndl: TIdSSLIOHandlerSocketOpenSSL;
    procedure HTTPWorkBegin(ASender: TObject; AWorkMode: TWorkMode;
      AWorkCountMax: Int64);
    procedure HTTPWork(ASender: TObject; AWorkMode: TWorkMode;
      AWorkCount: Int64);
    procedure HTTPWorkEnd(Sender: TObject; AWorkMode: TWorkMode);
    procedure SetProgress(const Value: Integer);
    procedure SetOnChange(const Value: TNotifyEvent);
    procedure SetBytesToTransfer(const Value: Int64);
  public
    constructor Create(AOwner: TComponent);
    procedure DownloadFile(const aFileUrl: string;
      const aDestinationFile: String);
    Destructor Destroy; override;
  published
    property Progress: Integer read FProgress write SetProgress;
    property BytesToTransfer: Int64 read FBytesToTransfer
      write SetBytesToTransfer;
    property OnChange: TNotifyEvent read FOnChange write SetOnChange;
  end;

implementation

uses
  Sysutils;

{ TIdHTTPProgress }

constructor TIdHTTPProgress.Create(AOwner: TComponent);
begin
  inherited;
  IOHndl := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
  IOHndl.SSLOptions.SSLVersions := [sslvTLSv1_2];
  Request.BasicAuthentication := True;
  HandleRedirects := True;
  IOHandler := IOHndl;
  ReadTimeout := 30000;

  OnWork := HTTPWork;
  OnWorkBegin := HTTPWorkBegin;
  OnWorkEnd := HTTPWorkEnd;
end;

destructor TIdHTTPProgress.Destroy;
begin
  IOHndl.Free;

  inherited;
end;

procedure TIdHTTPProgress.DownloadFile(const aFileUrl: string;
  const aDestinationFile: String);
var
  LDestStream: TFileStream;
  aPath: String;
begin
  Progress := 0;
  FBytesToTransfer := 0;
  aPath := ExtractFilePath(aDestinationFile);
  if aPath <> '' then
    ForceDirectories(aPath);

  LDestStream := TFileStream.Create(aDestinationFile, fmCreate);
  try
    Get(aFileUrl, LDestStream);
  finally
    FreeAndNil(LDestStream);
  end;
end;

procedure TIdHTTPProgress.HTTPWork(ASender: TObject; AWorkMode: TWorkMode;
  AWorkCount: Int64);
begin
  if BytesToTransfer = 0 then
    Exit;

  Progress := Round((AWorkCount / BytesToTransfer) * 100);
end;

procedure TIdHTTPProgress.HTTPWorkBegin(ASender: TObject; AWorkMode: TWorkMode;
  AWorkCountMax: Int64);
begin
  FBytesToTransfer := AWorkCountMax;
end;

procedure TIdHTTPProgress.HTTPWorkEnd(Sender: TObject; AWorkMode: TWorkMode);
begin
  FBytesToTransfer := 0;
  Progress := 100;
end;

procedure TIdHTTPProgress.SetBytesToTransfer(const Value: Int64);
begin
  FBytesToTransfer := Value;
end;

procedure TIdHTTPProgress.SetOnChange(const Value: TNotifyEvent);
begin
  FOnChange := Value;
end;

procedure TIdHTTPProgress.SetProgress(const Value: Integer);
begin
  FProgress := Value;
  if Assigned(FOnChange) then
    FOnChange(Self);
end;

end.
