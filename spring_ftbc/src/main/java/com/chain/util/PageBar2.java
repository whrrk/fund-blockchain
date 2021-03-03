package com.chain.util;

public class PageBar2 {
   //전체레코드 갯수
   private int totalRecord;
   //페이지당 레코드 수
   private int numPerPage;
   //블럭당 디폴트 페이지 수 - 여기서는 일단 2개로 정함
   private int pagePerBlock=10;
   //총 페이지수
   private int totalPage;
   //총블럭수
   private int totalBlock;
   //현재 내가 바라보는 블럭 수
   private int nowBlock;
   //현재 내가 바라보는 페이지
   private int nowPage;
   //넘어갈 페이지
   private String pagePath;
   //스트링버퍼 생성
   private String pagination;
   //페이지 네비게이션 초기화
   /*
    * 화면에서 받아와야하는 정보에는 어떤것들이 있을까? 
    * ->현재 내가 바라보는 페이지 번호 nowPage, 전체레코드수 totalRecord, 페이지에 뿌려질 로우의 수 numberPerPage
    * ->내가 처리해야할 페이지 이름 pagePath
    * 공식을 세우는데 필요한 인자는 누구? 현재페이지 - nowPage
    * 
    * 세워진 공식들은 어디에서 적용하면 되는 거지? 
    * ->nowBlock는 nowPage/pagePerBlock
    * 
    * 화면에 내보내져야하는 언어는 html 아님 자바중에서?
    * ->html로 만들어져야함
    * 
    * 내보내지는 정보는 어디에 담으면 될까?
    */
   public PageBar2(int numPerPage,int totalRecord, int nowPage, String pagePath) {
      this.numPerPage = numPerPage;
      this.totalRecord = totalRecord;
      this.nowPage = nowPage;
      this.pagePath = pagePath;
      this.totalPage = (int)Math.ceil((double)this.totalRecord/this.numPerPage);//전체 페이지는 총 레코드수 / 페이지당 담길 레코드수
      this.totalBlock = (int)Math.ceil((double)this.totalPage/this.pagePerBlock);//전체 블록은 전체 페이지수 / 페이지당 보여질 블록의 수
      this.nowBlock = (int)((double)this.nowPage/this.pagePerBlock);//0부터 시작할때는 1.5값이 나와도 내려야 하기 때문에 int로 형전환해줘서 실수부분을 버려주는것.
   }
   //setter메소드 선언
   public void setPageBar() {
      StringBuilder pageLink = new StringBuilder();
      //전체 레코드 수가 0보다 클때 처리하기
      if(totalRecord>0) {
         //nowBlock이 0보다 클때 처리
         //이전 페이지로 이동 해야 하므로 페이지 번호에 a태그를 붙여야 하고
         //pagePath뒤에 이동할 페이지 번호를 붙여서 호출 해야함.
         if(nowBlock>0) { //0번째일경우 전 블록으로 넘어가는 버튼을 만들 필요가 없음.
            pageLink.append("<a href='javascript: sibal("+((nowBlock-1)*pagePerBlock+(pagePerBlock-1))+")'>");
            pageLink.append("<img border=0 src='/FTBC_Images/bu_a.gif'>");
            pageLink.append("</a>&nbsp;&nbsp;"); //여기서 1블록일경우 1번으로 가도록 구현 해놓음.
         }
         for(int i=0;i<pagePerBlock;i++) {
            //현재 내가 보고 있는 페이지 블록 일때와
            if(nowBlock*pagePerBlock+i==nowPage) { 
               pageLink.append("<b>"+(nowBlock*pagePerBlock+i+1)+"</b>&nbsp;");
               
            }//그렇지 않을 때
            else { //현재페이지가 3이면, 0번을 넣고 반복할때는 else로 감.
               pageLink.append("<a href='javascript: sibal("+((nowBlock*pagePerBlock)+i)+")'>"+((nowBlock*pagePerBlock)+i+1)+"</a>&nbsp;");   
            }
            //모든 경우에 pagePerBlock만큼 반복되지 않으므로 브레이크 처리를 해야함.
            if((nowBlock*pagePerBlock)+i+1==totalPage) break;
         }
            //현재 블록에서 다음 블록이 존재할 경우 이미지를 추가하고 페이지 이동할 수 있도록 a태그를 활용하여 링크 처리하기
            if(totalBlock > nowBlock+1) { //0부터 시작하기때문에 1을 더한값을 비교대상으로 삼는다. 
               //1번째 블록(0부터 시작임)일경우 무조건 4번으로 가도록.
        	   pageLink.append("&nbsp;&nbsp;&nbsp;<a href='javascript: sibal("+((nowBlock+1)*pagePerBlock)+"')/>");
//               pageLink.append("&nbsp;&nbsp;&nbsp;<a href='"+pagePath+"?nowPage="+((nowBlock+1)*pagePerBlock)+"'>");
               pageLink.append("<img border=0 src='/FTBC_Images/bu_b.gif'>");
               pageLink.append("</a>");
         }
      }
      pagination = pageLink.toString();
   }
   //getter메소드 선언
   public String getPageBar() {
      this.setPageBar();
      return pagination;
   }
   
}