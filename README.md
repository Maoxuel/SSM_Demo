# SSM_Demo
初学整合SSM框架的小demo
SSM整合CRUD：

技术点：
------
	1.基础框架-ssm
	2.数据库-MySQL
	3.前端框架-bootstrap快速搭建简洁美观页面
	4.项目依赖管理-Maven
	5.分页-pageHelper
	6.逆向工程-MyBatis Generator


基础环境搭建：
------
	1.创建maven工程
  
	2.引入项目依赖的jar包
		spring:
			spring-jdbc
			spring-aspects
			spring-test
		springmvc:
			spring-webmvc
		mybatis:
			mybatis
			mybatis-spring
		数据库连接池，驱动:
			c3po/druid
			mysql-connector-java
		其他:
			jstl,Servlet-api,unit,mybatis-generator-core
			MyBatis Generator逆向工程根据数据库中单表字段自动生成实体bean和对应mapper.xml

	3.引入bootstrap前端框架:
		使用参考Bootstrap官方文档
	4.编写ssm整合关键配置文件
		web.xml：
		springmvc.xml
		applicationContext.xml:
		mybatis.xml
		MBG.xml：用mybatis逆向工程生成对应的bean以及mapper
	5.测试mapper
		根据需要，有选择的增加或修改mapper中的sql语句操作
		联表查询等等

测试dao层
------
    推荐spring项目就可以用spring的单元测试，会自动注入所需要的组件
    1.导入springTest模块
    2.@RunWith(SpringJUnit4ClassRunner.class)
    使用@ContextConfiguration指定spring配置文件的位置
    3.直接autowired要使用的组件即可
	
	批量操作
	spring的applicationContext.xml中配置一个可以批量操作的SQLSession
    <bean class="org.mybatis.spring.SqlSessionTemplate" name="sqlSession">
	<constructor-arg name="sqlSessionFactory" ref="sqlSessionFactory" />
	<constructor-arg name="executorType" value="BATCH"/>
    </bean>
		    然后Autowires注入一个sqlsession对象，获取一个mapper，循环批量插入等操作
		    
Page Helper插件
------
	1.配置
	<!--引入pageHelper分页插件jar包-->
    <dependency>
      <groupId>com.github.pagehelper</groupId>
      <artifactId>pagehelper</artifactId>
      <version>5.0.0</version>
    </dependency>
	
	<!--在Mybatis的xml文件中配置pageHelper分页插件拦截器-->
    <plugins>
        <plugin interceptor="com.github.pagehelper.PageInterceptor">
            <!--分页参数合理化-->
            <property name="reasonable" value="true"/>
        </plugin>
    </plugins>
    
    
    2.使用
    @RequestMapping("/emps")
    public String getEmps(@RequestParam(value = "pn", defaultValue = "1") Integer pn, Model model) {
        //这是一个分页查询
        //引入PageHelper分页插件
        //在查询之前只需要调用,传入页码和大小
        PageHelper.startPage(pn, 5);
        //startPage后面紧跟的查询就是个分页查询
        List<Employee> list = employeeService.getAll();
        //使用pageInfo包装查询后的结果，只需要将pageInfo交给页面就行了
        //它封装了详细的分页的信息，包括查询出的结果,传入连续显示的页数
        PageInfo page = new PageInfo(list, 5);
        model.addAttribute("pageInfo", page);
        return "list";
    }
