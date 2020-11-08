import { Component, OnInit } from '@angular/core';
import { CriteriaService } from 'src/app/services/criteria-service/criteria.service';

@Component({
  selector: 'app-criteria',
  templateUrl: './criteria.component.html',
  styleUrls: ['./criteria.component.css']
})
export class CriteriaComponent implements OnInit {
  criteria: Array<any>;
  currentUser = localStorage.getItem('currentRa')
  inputMode = false;
  constructor(private CriteriaService: CriteriaService) { }

  ngOnInit(): void {
    this.showMediumCriteria();
  }
  showMediumCriteria(){
    this.CriteriaService.showMediumCriteria()
      .subscribe(data => this.criteria = data)
  }
  

}
