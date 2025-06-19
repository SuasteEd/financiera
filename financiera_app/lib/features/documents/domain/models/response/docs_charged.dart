class DocsCharged {
  int id;
  String type;
  String status;
  String filePath;
  String showUrl;
  String downloadFile;

  DocsCharged({
    required this.id,
    required this.type,
    required this.status,
    required this.filePath,
    required this.showUrl,
    required this.downloadFile,
  });

  factory DocsCharged.fromJson(Map<String, dynamic> json) => DocsCharged(
    id: json["id"],
    type: json["type"],
    status: json["status"],
    filePath: json["file_path"],
    showUrl: json["show_url"],
    downloadFile: json["download_file"],
  );
}
