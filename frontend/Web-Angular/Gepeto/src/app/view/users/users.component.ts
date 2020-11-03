import { UsersService } from './../../services/users-services/users.service'
import { Component, OnInit } from '@angular/core';

@Component({
  selector: 'app-users',
  templateUrl: './users.component.html',
  styleUrls: ['./users.component.css']
})
export class UsersComponent implements OnInit {
  users: Array<any>;

  constructor(private UsersService: UsersService) { }

  ngOnInit(): void {
    this.showUsers();
  }
  showUsers() {
    this.UsersService.showUsers()
      .subscribe(data => this.users = data);
  }
  removeUser(userId: number) {
    this.users.splice(userId, 1)
  }
}
