unit DownloadManagerApp.Model.FiredacQuery;

interface

uses DownloadManagerApp.Model.Interfaces, FireDAC.Stan.Intf, FireDAC.DApt,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.VCLUI.Wait, FireDAC.Comp.Client;

Type
  TModelFiredacQuery = class(TInterfacedObject, iModelQuery)
  private
    FQuery: TFDQuery;
    FConexao: iModelConexao;
  public
    constructor Create(aValue: iModelConexao);
    destructor Destroy; override;
    class function New(aValue: iModelConexao): iModelQuery;
    function Query: TObject;
    function Open(aSQL: String): iModelQuery;
    function ExecSQL(aSQL: String): iModelQuery;
    function ExecSQLReturning(aSQL: String): Integer;
  end;

implementation

uses
  System.SysUtils;

{ TModelFiredacQuery }

constructor TModelFiredacQuery.Create(aValue: iModelConexao);
begin
  FConexao := aValue;
  FQuery := TFDQuery.Create(nil);
  FQuery.Connection := TFDConnection(FConexao.Connection);
end;

destructor TModelFiredacQuery.Destroy;
begin
  FreeAndNil(FQuery);
  inherited;
end;

function TModelFiredacQuery.ExecSQLReturning(aSQL: String): Integer;
begin
  Result := TFDConnection(FConexao.Connection).ExecSQLScalar(aSQL);
end;

function TModelFiredacQuery.ExecSQL(aSQL: String): iModelQuery;
begin
  Result := Self;
  FQuery.ExecSQL(aSQL);
end;

class function TModelFiredacQuery.New(aValue: iModelConexao): iModelQuery;
begin
  Result := Self.Create(aValue);
end;

function TModelFiredacQuery.Open(aSQL: String): iModelQuery;
begin
  Result := Self;
  FQuery.Open(aSQL);
end;

function TModelFiredacQuery.Query: TObject;
begin
  Result := FQuery;
end;

end.
