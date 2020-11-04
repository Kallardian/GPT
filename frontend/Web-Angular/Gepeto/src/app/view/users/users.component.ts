import { UsersService } from './../../services/users-services/users.service'
import { FormBuilder, FormGroup, Validators } from '../../../../node_modules/@angular/forms'
import { Component, OnInit } from '@angular/core';

@Component({
  selector: 'app-users',
  templateUrl: './users.component.html',
  styleUrls: ['./users.component.css']
})
export class UsersComponent implements OnInit {
  users: Array<any>;
  formUser: FormGroup;

  constructor(private UsersService: UsersService, private fb: FormBuilder) { }

  ngOnInit(): void {
    this.showUsers();
    this.createUserForm();
  }
  showUsers() {
    this.UsersService.showUsers()
      .subscribe(data => this.users = data);
  }
  removeUser(userId: number) {
    this.UsersService.deleteUser(userId);
  }
  createUserForm() {
    this.formUser = this.fb.group({
      ra: [
        '',
        Validators.compose([
          Validators.required,
          Validators.minLength(6),
          Validators.maxLength(6)
        ])
      ],
      fullname: [
        '',
        Validators.compose([
          Validators.required,
          Validators.minLength(3),
          Validators.maxLength(30)
        ])
      ],
      password: [
        '',
        Validators.compose([
          Validators.required,
          Validators.minLength(3),
          Validators.maxLength(30)
        ])
      ],
      access: [
        '',
        Validators.compose([
          Validators.required,
        ])
      ]
    });
  }
  saveUser(){
    console.log(this.formUser.value)
  }
}
