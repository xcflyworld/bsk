package com.bsk.service.impl;

import com.bsk.dao.CategoryDao;
import com.bsk.dao.impl.CategoryDaoImpl;
import com.bsk.po.Category;
import com.bsk.service.CategoryService;

import java.util.List;

/**
 * @author scmie
 */
public class CategoryServiceImpl implements CategoryService {
    private CategoryDao categoryDao = new CategoryDaoImpl();
    @Override
    public List<Category> getCategoryList(Category category) {
        return categoryDao.getCategoryList(category);
    }

    @Override
    public int addCategory(Category category) {
        return categoryDao.addCategory(category);
    }

    @Override
    public int updateCategory(Category category) {
        return categoryDao.updateCategory(category);
    }

    @Override
    public int delCategory(Category category) {
        return categoryDao.delCategory(category);
    }
}
