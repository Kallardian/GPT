package com.grupo.de.pessoas.tristes.gepeto.dtos;

import javax.persistence.*;

@NamedStoredProcedureQuery(name = "SP_SHOW_MEDIUM_GRADE_GROUP_1", procedureName = "SP_SHOW_MEDIUM_GRADE_GROUP_1",
        parameters = {
                @StoredProcedureParameter(name = "group_id", type = Long.class, mode = ParameterMode.IN)
        }
)

@NamedStoredProcedureQuery(name = "SP_SHOW_MEDIUM_GRADE_GROUP", procedureName = "SP_SHOW_MEDIUM_GRADE_GROUP")

@Entity
@Table(name = "TB_MEDIUM_GRADES_GROUP")
public class FinalGrade {

    //Attributes
    @Id
    @Column(name = "NAME_MEDIUM")
    private String nameCriterion;
    @Column(name = "GRADE")
    private double grade;

    //Methods
    public String getNameCriterion() {
        return nameCriterion;
    }

    public void setNameCriterion(String nameCriterion) {
        this.nameCriterion = nameCriterion;
    }

    public double getGrade() {
        return grade;
    }

    public void setGrade(double grade) {
        this.grade = grade;
    }
}
