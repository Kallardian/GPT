package com.grupo.de.pessoas.tristes.gepeto.dtos;

import javax.persistence.*;

//Function
@NamedStoredProcedureQuery(name = "SP_AMOUNT_CLASSROOMS", procedureName = "SP_AMOUNT_CLASSROOMS")

//GET
@NamedStoredProcedureQuery(name = "SP_FIND_CLASSROOM", procedureName = "SP_FIND_CLASSROOM",
        parameters = {
                @StoredProcedureParameter(name = "classroom_id", type = Long.class, mode = ParameterMode.IN)
        }
)

@NamedStoredProcedureQuery(name = "SP_SHOW_CLASSROOMS", procedureName = "SP_SHOW_CLASSROOMS")

//POST
@NamedStoredProcedureQuery( name = "SP_INSERT_CLASSROOM", procedureName = "SP_INSERT_CLASSROOM",
        parameters = {
                @StoredProcedureParameter(name = "amount_classroom", type = Integer.class, mode = ParameterMode.IN),
        }
)

//DELETE
@NamedStoredProcedureQuery(name = "SP_DELETE_CLASSROOM", procedureName = "SP_DELETE_CLASSROOM",
        parameters = {
                @StoredProcedureParameter(name = "classroom_name", type = String.class, mode = ParameterMode.IN)
        }
)

@Entity
@Table(name = "TB_CLASSROOM")
public class Classroom {

    //Attributes
    @Id
    @Column(name = "ID_CLASSROOM")
    private Long idClassroom;
    @Column(name = "NAME_CLASSROOM")
    private String nameClassroom;
    @Column(name = "YEAR")
    private int year;


    //Methods
    public Long getIdClassroom() {
        return idClassroom;
    }

    public void setIdClassroom(Long idClassroom) {
        this.idClassroom = idClassroom;
    }

    public String getNameClassroom() {
        return nameClassroom;
    }

    public void setNameClassroom(String nameClassroom) {
        this.nameClassroom = nameClassroom;
    }

    public int getYear() {
        return year;
    }

    public void setYear(int year) {
        this.year = year;
    }
}
