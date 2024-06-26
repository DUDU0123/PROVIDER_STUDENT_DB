import 'package:provider_student_db/data/db_functions.dart';
import 'package:provider_student_db/model/student_database_model.dart';

class DbServicer{
  late DbFunctions _dbFunctions;

  DbServicer(){
    _dbFunctions = DbFunctions();
  }

  addStudentToDB(StudentDataBaseModel student) async {
    return await _dbFunctions.inserDataToDB('studentdb', student.fromMap());
  }

  getAllStudentsFromDB() async {
    return await _dbFunctions.getAllDataFromDB('studentdb');
  }

  updateStudentData(StudentDataBaseModel student) async {
    return await _dbFunctions.updateOneUserInDB('studentdb', student.fromMap());
  }

  deleteStudentData(id) async {
    return await _dbFunctions.deleteDataById('studentdb', id);
  }

  getOneStudentFromDbList(StudentDataBaseModel name) async {
    return await _dbFunctions.getDataFromDBbyId('studentdb', name);
  }
}