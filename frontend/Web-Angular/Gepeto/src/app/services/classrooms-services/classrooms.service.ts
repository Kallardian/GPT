import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http'
import { take } from 'rxjs/operators'

@Injectable({
  providedIn: 'root'
})
export class ClassroomsService {

  showClassroomsUrl = "/api/classrooms/show/";
  postClassroomUrl = "/api/classrooms/post/";
  deleteClassroomUrl = "/api/classrooms/delete/";

  constructor(private http: HttpClient) { }

  showClassrooms() {
    return this.http.get<any[]>(`${this.showClassroomsUrl}`)
  }

  addClassroms(givenNumberOfClassrooms: number) {
    this.postClassroomUrl = this.postClassroomUrl + givenNumberOfClassrooms.toString();
    return this.http.post(`${this.postClassroomUrl} `, givenNumberOfClassrooms)
  }

  removeClassroom(classroomId: number) {
    this.deleteClassroomUrl = this.deleteClassroomUrl.replace(/\d+/g, '');
    this.deleteClassroomUrl = this.deleteClassroomUrl + classroomId.toString();
    return this.http.delete(`${this.deleteClassroomUrl}`)
   }

}
