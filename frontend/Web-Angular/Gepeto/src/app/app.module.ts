import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';
import { ReactiveFormsModule } from "@angular/forms";

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { LoginComponent } from './view/login/login.component';
import { ClassroomsComponent } from './view/classrooms/classrooms.component';
import { GroupsComponent } from './view/groups/groups.component';

@NgModule({
  declarations: [
    AppComponent,
    LoginComponent,
    ClassroomsComponent,
    GroupsComponent
  ],
  imports: [
    BrowserModule,
    AppRoutingModule, 
    ReactiveFormsModule
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }
