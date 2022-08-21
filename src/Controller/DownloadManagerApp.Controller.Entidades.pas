unit DownloadManagerApp.Controller.Entidades;

interface

uses
  DownloadManagerApp.Controller.Interfaces,
  DownloadManagerApp.Model.Interfaces;

Type
  TControllerEntidades = class(TInterfacedObject, iControllerEntidades)
  private
    FModelEntidades: iModelEntidadeFactory;
  public
    constructor Create;
    destructor Destroy; override;
    class function New: iControllerEntidades;
    function Entidades: iModelEntidadeFactory;
  end;

implementation

uses
  DownloadManagerApp.Model.EntidadesFactory;

{ TControllerEntidades }

constructor TControllerEntidades.Create;
begin
  FModelEntidades := TModelEntidadesFactory.New;
end;

destructor TControllerEntidades.Destroy;
begin
  inherited;
end;

function TControllerEntidades.Entidades: iModelEntidadeFactory;
begin
  Result := FModelEntidades;
end;

class function TControllerEntidades.New: iControllerEntidades;
begin
  Result := Self.Create;
end;

end.
