unit DownloadManagerApp.Model.EntidadesFactory;

interface

uses
  DownloadManagerApp.Model.Interfaces;

type
    TModelEntidadesFactory = class(TInterfacedObject, iModelEntidadeFactory)
    private
        FHistorico : iModelEntidade;
    public
        constructor Create;
        destructor Destroy; override;
        class function New : iModelEntidadeFactory;
        function Historico : iModelEntidade;
    end;

implementation

uses
  DownloadManagerApp.Model.EntidadeHistorico;

{ TModelEntidadesFactory }

constructor TModelEntidadesFactory.Create;
begin

end;

destructor TModelEntidadesFactory.Destroy;
begin
    inherited;
end;

class function TModelEntidadesFactory.New: iModelEntidadeFactory;
begin
    Result := Self.Create;
end;

function TModelEntidadesFactory.Historico: iModelEntidade;
begin
   if not Assigned(FHistorico) then
       FHistorico := TModelEntidadeHistorico.New;
   Result := FHistorico;
end;

end.
