import { StringMap } from "@angular/compiler/src/compiler_facade_interface";

export class Group{
    constructor(
        public id: number,
        public groupTheme: string,
        public description: string,
        public idClassroom: number,
        public ra: string,
    ){ }
}