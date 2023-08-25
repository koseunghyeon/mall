package com.himedia.springboot;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface G_DAO {
	ArrayList<g_boardDTO> g_getBoard();
	void boardInsert(String title,String userid,String content);
	g_boardDTO findBoard(int boardNum);
	void g_delete(int boardNum);
	void boardUpdate(int boardNum,String title,String content);
	void g_hitup(int boardNum);
	ArrayList<g_commentDTO> findComment(int boardNum);
	void insertComment(String userid, int boardNum, String commentBox);
	void g_commentDelete(int c_num);
}
