
import { Component, OnInit } from '@angular/core';

import { GroupsService } from 'src/app/services/groups-services/groups.service';

@Component({
  selector: 'app-groups',
  templateUrl: './groups.component.html',
  styleUrls: ['./groups.component.css']
})
export class GroupsComponent implements OnInit {

  groups: Array<any>;

 
  
  constructor(private GroupService: GroupsService) { }

  ngOnInit(): void {
    this.showGroups();


  }

  showGroups(){
    this.GroupService.showGroups()
      .subscribe(data => 
        {
          this.groups = data
        });
  }
  // isThereGroups(classroomId: number): boolean{
  //   this.GroupService.showGroups()
  //     .subscribe(data => 
  //       {
  //         this.groups = data
  //       });
      
  // }

}
