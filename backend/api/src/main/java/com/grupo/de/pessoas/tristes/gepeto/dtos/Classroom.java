package com.grupo.de.pessoas.tristes.gepeto.dtos;

import javax.persistence.*;

@NamedStoredProcedureQuery(
        name = "SP_FIND_CLASSROOM",
        procedureName = "SP_FIND_CLASSROOM",
        parameters = {
                @StoredProcedureParameter(name = "classroom_id", type = Integer.class, mode = ParameterMode.IN)
        }
)

@Entity
@Table(name = "TB_CLASSROOM")
public class Classroom {

    @Id
    @Column(name = "ID_CLASSROOM")
    private Long idClassroom;
    @Column(name = "NAME_CLASSROOM")
    private String name;
    @Column(name = "YEAR")
    private int year;

    public Long getIdClassroom() {
        return idClassroom;
    }

    public void setIdClassroom(Long idClassroom) {
        this.idClassroom = idClassroom;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getYear() {
        return year;
    }

    public void setYear(int year) {
        this.year = year;
    }
}
