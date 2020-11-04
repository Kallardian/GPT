import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http'

@Injectable({
  providedIn: 'root'
})
export class CriteriaService {

  showMediumCriteriaUrl = 'http://localhost:3001/medium-criteria/'

  constructor(private http: HttpClient) { }

  showMediumCriteria(){
    return this.http.get<any[]>(`${this.showMediumCriteriaUrl}`)
  }
}
