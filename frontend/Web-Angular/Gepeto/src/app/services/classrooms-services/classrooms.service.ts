import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http'

@Injectable({
  providedIn: 'root'
})
export class ClassroomsService {

  showClassroomsUrl = "http://localhost:3001/classrooms/";
  
  constructor(private http: HttpClient) { }

  showClassrooms(){
    return this.http.get<any[]>(`${this.showClassroomsUrl}`)
  }
  
}
