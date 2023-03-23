package com.bsk.service;

import com.bsk.po.Category;

import java.util.List;

/**
 * @author scmie
 */
public interface CategoryService {

    /**
     * 获取所有分类
     *
     * @param category
     * @return
     */
    List<Category> getCategoryList(Category category);


    /**
     *   根据属性获取对象
     * @param category
     * @return
     */


    /**
     * 添加新分类
     * @param address
     * @return
     */
    int addCategory(Category category);


    /**
     * 更新分类
     * @param category
     * @return
     */
    int updateCategory(Category category);


    /**
     * 删除分类
     * @param category
     * @return
     */
    int delCategory(Category category);
}
