import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';

@Injectable({
  providedIn: 'root'
})
export class GradesService {

  gradesUrl = '/api/final-grades/'

  constructor(private http: HttpClient) { }  

  showGrades(groupId: string){
    return this.http.get<any[]>(`${this.gradesUrl + groupId}`)
  }
  
}
