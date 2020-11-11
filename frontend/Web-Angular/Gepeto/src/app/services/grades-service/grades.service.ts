import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http';

@Injectable({
  providedIn: 'root'
})
export class GradesService {

  gradesUrl = '/api/medium-grades/'

  constructor(private http: HttpClient) { }  

  showGrades(){
    return this.http.get<any[]>(`${this.gradesUrl}`)
  }
  
}
