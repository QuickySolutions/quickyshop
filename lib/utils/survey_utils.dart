class QuestionTypeItem {
  String name;
  String keyType;

  QuestionTypeItem({required this.name, required this.keyType});
}

List<QuestionTypeItem> questionTypes = [
  QuestionTypeItem(name: 'Multiple selección', keyType: 'check'),
  QuestionTypeItem(name: 'Cerrado', keyType: 'close'),
  QuestionTypeItem(name: 'Seleccionar un Item', keyType: 'combo-box'),
  QuestionTypeItem(name: 'Opinión corta', keyType: 'mini-review'),
  QuestionTypeItem(name: 'Opinión larga', keyType: 'large-review'),
  QuestionTypeItem(name: 'Unica selección', keyType: 'radio'),
  QuestionTypeItem(name: 'Escalar', keyType: 'scale')
];
