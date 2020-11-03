import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';
import { ReactiveFormsModule } from "@angular/forms";
import { HttpClientModule } from '@angular/common/http'

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { LoginComponent } from './view/login/login.component';
import { ClassroomsComponent } from './view/classrooms/classrooms.component';
import { GroupsComponent } from './view/groups/groups.component';
import { ClassroomsService } from './services/classrooms-services/classrooms.service';
import { UsersComponent } from './view/users/users.component'

@NgModule({
  declarations: [
    AppComponent,
    LoginComponent,
    ClassroomsComponent,
    GroupsComponent,
    UsersComponent
  ],
  imports: [
    BrowserModule,
    AppRoutingModule, 
    ReactiveFormsModule,
    HttpClientModule
  ],
  providers: [ClassroomsService],
  bootstrap: [AppComponent]
})
export class AppModule { }
