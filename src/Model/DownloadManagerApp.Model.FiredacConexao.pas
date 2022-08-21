unit DownloadManagerApp.Model.FiredacConexao;

interface

uses DownloadManagerApp.Model.Interfaces, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.VCLUI.Wait, FireDAC.Comp.Client, FireDAC.DApt;

Type
  TModelFiredacConexao = class(TInterfacedObject, iModelConexao)
  private
    FConexao: TFDConnection;
  public
    constructor Create;
    destructor Destroy; override;
    class function New: iModelConexao;
    function Connection: TObject;
  end;

implementation

uses
  System.SysUtils, Vcl.Forms;

{ TModelFiredacConexao }

function TModelFiredacConexao.Connection: TObject;
begin
  Result := FConexao;
end;

constructor TModelFiredacConexao.Create;
begin
  FConexao := TFDConnection.Create(nil);
  FConexao.Params.DriverID := 'SQLite';
  FConexao.Params.Database := ExtractFilePath(Application.ExeName) +
    'db\DownloadManager.db';
  FConexao.Connected := true;
end;

destructor TModelFiredacConexao.Destroy;
begin
  FreeAndNil(FConexao);
  inherited;
end;

class function TModelFiredacConexao.New: iModelConexao;
begin
  Result := Self.Create;
end;

end.
