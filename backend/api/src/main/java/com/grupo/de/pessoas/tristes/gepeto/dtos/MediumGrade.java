package com.grupo.de.pessoas.tristes.gepeto.dtos;

import javax.persistence.*;
import java.util.List;

//Function
@NamedStoredProcedureQuery(name = "SP_BIGGEST_ATTEMPT", procedureName = "SP_BIGGEST_ATTEMPT",
        parameters = {
                @StoredProcedureParameter(name = "id_group", type = Long.class, mode = ParameterMode.IN)
        }
)

//GET
@NamedStoredProcedureQuery(name = "SP_FIND_MEDIUM_GRADE", procedureName = "SP_FIND_MEDIUM_GRADE",
        parameters = {
                @StoredProcedureParameter(name = "id_medium_grade", type = Long.class, mode = ParameterMode.IN)
        }
)

@NamedStoredProcedureQuery(name = "SP_SHOW_MEDIUM_GRADE", procedureName = "SP_SHOW_MEDIUM_GRADE")

@NamedStoredProcedureQuery(name = "SP_SHOW_MEDIUM_GRADE_GROUP", procedureName = "SP_SHOW_MEDIUM_GRADE_GROUP",
        parameters = {
                @StoredProcedureParameter(name = "group_id", type = Long.class, mode = ParameterMode.IN)
        }
)

@NamedStoredProcedureQuery(name = "SP_SHOW_FINAL_GRADE_GROUP", procedureName = "SP_SHOW_FINAL_GRADE_GROUP",
        parameters = {
                @StoredProcedureParameter(name = "group_id", type = Long.class, mode = ParameterMode.IN)
        }
)

//POST
@NamedStoredProcedureQuery( name = "SP_INSERT_MEDIUM_GRADE", procedureName = "SP_INSERT_MEDIUM_GRADE",
        parameters = {
                @StoredProcedureParameter(name = "id_medium", type = Long.class, mode = ParameterMode.IN),
                @StoredProcedureParameter(name = "ra", type = String.class, mode = ParameterMode.IN),
                @StoredProcedureParameter(name = "id_group", type = Long.class, mode = ParameterMode.IN),
                @StoredProcedureParameter(name = "grade", type = Double.class, mode = ParameterMode.IN),
                @StoredProcedureParameter(name = "attempt", type = int.class, mode = ParameterMode.IN)
        }
)

@NamedStoredProcedureQuery(name = "SP_INSERT_LIST_MEDIUM_GRADE", procedureName = "SP_INSERT_LIST_MEDIUM_GRADE",
        parameters = {
                @StoredProcedureParameter(name = "listMediumGrades", type = List.class, mode = ParameterMode.IN)
        }
)

@Entity
@Table(name = "TB_MEDIUM_GRADE")
public class MediumGrade {

    //Attributes
    @Id
    @Column(name = "ID_MEDIUM_GRADE")
    private Long idMediumGrade;
    @Column(name = "RA")
    private String ra;
    @Column(name = "ID_MEDIUM")
    private Long idMedium;
    @Column(name = "ID_GROUP")
    private Long idGroup;
    @Column(name = "GRADE")
    private double grade;
    @Column(name = "ATTEMPT")
    private int attempt;


    //Methods
    public Long getIdMediumGrade() {
        return idMediumGrade;
    }

    public void setIdMediumGrade(Long idMediumGrade) {
        this.idMediumGrade = idMediumGrade;
    }

    public String getRa() {
        return ra;
    }

    public void setRa(String ra) {
        this.ra = ra;
    }

    public Long getIdMedium() {
        return idMedium;
    }

    public void setIdMedium(Long idMedium) {
        this.idMedium = idMedium;
    }

    public Long getIdGroup() {
        return idGroup;
    }

    public void setIdGroup(Long idGroup) {
        this.idGroup = idGroup;
    }

    public double getGrade() {
        return grade;
    }

    public void setGrade(double grade) {
        this.grade = grade;
    }

    public int getAttempt() {
        return attempt;
    }

    public void setAttempt(int attempt) {
        this.attempt = attempt;
    }
}
