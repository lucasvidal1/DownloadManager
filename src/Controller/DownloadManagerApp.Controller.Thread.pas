unit DownloadManagerApp.Controller.Thread;

interface

uses System.Classes, Vcl.ComCtrls, DownloadManagerApp.Controller.Interfaces,
  DownloadManagerApp.Controller.Download, DownloadManagerApp.Util.Download,
  IdComponent, Vcl.Forms;

type
  TThreadDownload = class(TThread)
  private
    FDownload: iControllerDownload;
  public
    constructor Create(pDownload: iControllerDownload);
    procedure Execute; override;
    procedure Desconectar;
    destructor Destroy; override;
  end;

implementation

uses
  Vcl.Dialogs;

{ TThreadDownload }

constructor TThreadDownload.Create(pDownload: iControllerDownload);
begin
  inherited Create(True);

  FDownload := pDownload;
end;

procedure TThreadDownload.Desconectar;
begin
  FDownload.CancelarDownload;
  Terminate;
end;

destructor TThreadDownload.Destroy;
begin

  inherited;
end;

procedure TThreadDownload.Execute;
begin
  inherited;
  FDownload.IniciarDownload;
end;

end.
