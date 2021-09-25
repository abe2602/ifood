abstract class MockServerException implements Exception {}

abstract class FormFieldException implements MockServerException {}

class GenericException implements MockServerException {}

class NoConnectionException implements MockServerException {}

class EmptyTextFieldException implements FormFieldException {}

class InvalidTextFieldException implements FormFieldException {}