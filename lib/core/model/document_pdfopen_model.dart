class PDFOpenModel{
  String intID;
  String bisEngineerRead;
  String isModeifiedBy;

  PDFOpenModel(
      {
        this.intID,
        this.bisEngineerRead,
        this.isModeifiedBy,
        });

  PDFOpenModel.fromJson(Map<String, dynamic> json) {
    intID = json['intID'];
    bisEngineerRead = json['bisEngineerRead'];
    isModeifiedBy = json['isModeifiedBy'];
    
  }
Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['intID'] = this.intID;
    data['bisEngineerRead'] = this.bisEngineerRead;
    data['isModeifiedBy'] = this.isModeifiedBy;
    return data;
  }
}

