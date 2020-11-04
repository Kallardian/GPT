import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http'
import { take } from 'rxjs/operators'

@Injectable({
  providedIn: 'root'
})
export class ClassroomsService {

  showClassroomsUrl = "http://localhost:3001/classrooms/show";
  postClassroomUrl = "http://localhost:3001/classrooms/post/5"
  
  constructor(private http: HttpClient) { }

  showClassrooms(){
    return this.http.get<any[]>(`${this.showClassroomsUrl}`)
  }

  addClassroms(givenNumberOfClassrooms: number){
    return this.http.post(`${ this.postClassroomUrl } `, givenNumberOfClassrooms)
  }
  
}
