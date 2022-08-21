unit DownloadManagerApp.Controller.Interfaces;

interface

uses
  DownloadManagerApp.Model.Interfaces;

type
  iControllerDownload = Interface
    ['{7CA41AC3-54FA-40FD-82F2-93AA043D0B89}']
    function SetUrl(Value: String): iControllerDownload;
    function SetCaminhoArquivo(Value: String): iControllerDownload;
    function GetProgressoDownload: String;
    function GetDownloadEmAndamento: Boolean;
    procedure SetInicioDownload;
    procedure SetFimDownload;
    procedure IniciarDownload;
    procedure CancelarDownload;
  End;

  iControllerEntidades = interface
    ['{D73994B9-06D2-44CD-BECF-C322E8EFD492}']
    function Entidades: iModelEntidadeFactory;
  end;

implementation

end.
