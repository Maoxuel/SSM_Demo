package com.mxl.service;

import com.mxl.dao.DepartmentMapper;
import com.mxl.domain.Department;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class DepartmentService {

    @Autowired
    private DepartmentMapper departmentMapper;
    public List<Department> getDepts() {
        return departmentMapper.selectByExample(null);
    }
}
