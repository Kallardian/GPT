import { Injectable } from '@angular/core';
import { HttpClient } from '@angular/common/http'
import { Criterion } from 'src/app/models/criterion';

@Injectable({
  providedIn: 'root'
})
export class CriteriaService {

  mediumCriteriaUrl = 'api/medium-criteria/'
  mediumGradesUrl = '/api/medium-grades/'
  bigCriterionUrl = '/api/big-criteria/'

  constructor(private http: HttpClient) { }

  showMediumCriteria(){
    return this.http.get<any[]>(`${this.mediumCriteriaUrl}`)
  }

  addCriterion(criterion: any){
    return this.http.post(this.mediumCriteriaUrl, criterion)
  }

  removeCriterion(criterionId: number){
    return this.http.delete(this.mediumCriteriaUrl + criterionId)
  }
  updateCriterion(criterion){
    return this.http.put(this.mediumCriteriaUrl, criterion)
  }


  showMediumGrades(){
    return this.http.get<any[]>(`${this.mediumGradesUrl}`)
  }
  addBigCriterion(){
    return this.http.post(this.bigCriterionUrl, "")
  }


}
