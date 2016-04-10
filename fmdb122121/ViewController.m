//
//  ViewController.m
//  fmdb122121
//
//  Created by yulingsong on 16/3/30.
//  Copyright © 2016年 yulingsong. All rights reserved.
//

#import "ViewController.h"
#import "FMDB.h"

@interface ViewController ()

//三个输入框
@property (nonatomic,strong) UITextField *nameText;
@property (nonatomic,strong) UITextField *ageText;
@property (nonatomic,strong) UITextField *salaryText;

//三个标签
@property (nonatomic,strong) UILabel *nameLabel;//姓名
@property (nonatomic,strong) UILabel *ageLabel;//年龄
@property (nonatomic,strong) UILabel *salaryLabel;//工资

//四个按钮，增删改查
@property (nonatomic,strong) UIButton *createBtn;//创建
@property (nonatomic,strong) UIButton *insertBtn;//插入
@property (nonatomic,strong) UIButton *clearBtn;//清除
@property (nonatomic,strong) UIButton *queryBtn;//查询

@property (nonatomic,strong) UITextView *describeView;//显示框

//FMDatabase数据库属性
@property (nonatomic,strong) FMDatabase *database;

@end

@implementation ViewController
@synthesize nameLabel,ageLabel,salaryLabel;
@synthesize nameText,ageText,salaryText;
@synthesize createBtn,insertBtn,clearBtn,queryBtn;
@synthesize describeView;

//主程序
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"数据库操作";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setLabels];//设置标签的方法
    [self setTextFields];//设置文本框的方法
    [self setButtons];//设置按钮的方法
}

//设置标签的方法
-(void)setLabels
{
    if (!self.nameLabel)
    {
        self.nameLabel = [[UILabel alloc]init];
        [self.view addSubview:nameLabel];
    }
    if (!self.ageLabel)
    {
        self.ageLabel = [[UILabel alloc]init];
        [self.view addSubview:ageLabel];
    }
    if (!self.salaryLabel)
    {
        self.salaryLabel = [[UILabel alloc]init];
        [self.view addSubview:salaryLabel];
    }
    
    nameLabel.text = @"姓名";
    nameLabel.frame = CGRectMake(20, 100, 40, 20);
    nameLabel.font = [UIFont systemFontOfSize:14];
    nameLabel.textColor = [UIColor blackColor];
   
    ageLabel.text = @"年龄";
    ageLabel.frame = CGRectMake(20, 150, 40, 20);
    ageLabel.font = [UIFont systemFontOfSize:14];
    ageLabel.textColor = [UIColor blackColor];
    
    salaryLabel.text = @"工资";
    salaryLabel.frame = CGRectMake(20, 200, 40, 20);
    salaryLabel.font = [UIFont systemFontOfSize:14];
    salaryLabel.textColor = [UIColor blackColor];
    
    
}

//设置文本框的方法
-(void)setTextFields
{
    if (!self.nameText)
    {
        self.nameText = [[UITextField alloc]init];
        [self.view addSubview:nameText];
    }
    if (!self.ageText)
    {
        self.ageText = [[UITextField alloc]init];
        [self.view addSubview:ageText];
    }
    if (!self.salaryText)
    {
        self.salaryText = [[UITextField alloc]init];
        [self.view addSubview:salaryText];
    }
    
    if (!self.describeView)
    {
        self.describeView = [[UITextView alloc]init];
        [self.view addSubview:describeView];
    }
    
    nameText.frame = CGRectMake(90, 100, 250, 20);
    nameText.placeholder = @"请输入姓名";
    nameText.font = [UIFont systemFontOfSize:14];
    nameText.borderStyle = UITextBorderStyleRoundedRect;
    
    ageText.frame = CGRectMake(90, 150, 250, 20);
    ageText.placeholder = @"请输入年龄";
    ageText.font = [UIFont systemFontOfSize:14];
    ageText.borderStyle = UITextBorderStyleRoundedRect;
    
    salaryText.frame = CGRectMake(90, 200, 250, 20);
    salaryText.placeholder = @"请输入工资";
    salaryText.font = [UIFont systemFontOfSize:14];
    salaryText.borderStyle = UITextBorderStyleRoundedRect;
    
    describeView.frame = CGRectMake(30, 250, 315, 200);
    describeView.font = [UIFont systemFontOfSize:14];
    describeView.backgroundColor = [UIColor cyanColor];
}

//设置按钮的方法
-(void)setButtons
{
    if (!self.createBtn)
    {
        self.createBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.view addSubview:createBtn];
    }
    if (!self.insertBtn)
    {
        self.insertBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.view addSubview:insertBtn];
    }
    if (!self.clearBtn)
    {
        self.clearBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.view addSubview:clearBtn];
    }
    if (!self.queryBtn)
    {
        self.queryBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.view addSubview:queryBtn];
    }
    
    createBtn.frame = CGRectMake(30, 500,120, 40);
    createBtn.backgroundColor = [UIColor cyanColor];
    [createBtn setTitle:@"创建" forState:UIControlStateNormal];
    [createBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    createBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [createBtn addTarget:self action:@selector(createData) forControlEvents:UIControlEventTouchUpInside];
    
    insertBtn.frame = CGRectMake(225, 500,120, 40);
    insertBtn.backgroundColor = [UIColor cyanColor];
    [insertBtn setTitle:@"插入" forState:UIControlStateNormal];
    [insertBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    insertBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [insertBtn addTarget:self action:@selector(insertData) forControlEvents:UIControlEventTouchUpInside];
    
    clearBtn.frame = CGRectMake(30, 560,120, 40);
    clearBtn.backgroundColor = [UIColor cyanColor];
    [clearBtn setTitle:@"清除" forState:UIControlStateNormal];
    [clearBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    clearBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [clearBtn addTarget:self action:@selector(clearData) forControlEvents:UIControlEventTouchUpInside];
    
    queryBtn.frame = CGRectMake(225, 560,120, 40);
    queryBtn.backgroundColor = [UIColor cyanColor];
    [queryBtn setTitle:@"查询" forState:UIControlStateNormal];
    [queryBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    queryBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [queryBtn addTarget:self action:@selector(queryData) forControlEvents:UIControlEventTouchUpInside];

}

//创建
-(void)createData
{
    NSLog(@"创建数据库和表");
    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
    NSString *sqlitePath = [documentsPath stringByAppendingPathComponent:@"person.sqlite"];
    //创建数据库文件
    self.database = [FMDatabase databaseWithPath:sqlitePath];
    //打开数据库
    if ([self.database open])
    {
        //创建表（更新操作）
        BOOL isSucess = [self.database executeUpdate:@"create table if not exists employee (id integer primary key, name text, age integer, salary real)"];
        if (!isSucess)
        {
            NSLog(@"创建表失败%@", [self.database lastError]);
        }
    }
    //关闭数据库
    [self.database close];
}

//插入
-(void)insertData
{
    NSLog(@"插入数据");
    if ([self.database open])
    {
        //插入数据：方式一、带有参数的插入sql语句
        
        NSString *name = nameText.text;
        NSNumber *age = @(ageText.text.intValue);
        NSNumber *salary = @(self.salaryText.text.doubleValue);
        BOOL isSucess = [self.database executeUpdate:@"insert into employee (name,age,salary) values (?,?,?)",name,age,salary];
        
        //方式二、带有参数的插入sql语句
        /*
         NSString *str = [NSString stringWithFormat:@"insert into employee (name,age,salary) values (%@,%d,%lf)",self.nameTextField.text,self.ageTextField.text.intValue ,self.salaryTextField.text.doubleValue];
         BOOL isSucess = [self.database executeUpdate:str];
         */
        if (!isSucess)
        {
            NSLog(@"插入数据失败%@", [self.database lastError]);
        }
    }
    [self.database close];
}

//查询
-(void)queryData
{
    NSLog(@"查询数据");
    if ([self.database open])
    {
        FMResultSet *resultSet = [self.database executeQuery:@"select *from employee"];
        //执行查询操作
        while ([resultSet next])
        {
            //一句插入数据的类型，调用方法名字不同
            int employee = [resultSet intForColumn:@"id"];
            NSString *name = [resultSet stringForColumn:@"name"];
            int age = [resultSet intForColumn:@"age"];
            double salary = [resultSet doubleForColumn:@"salary"];
            //更新到界面UITextView
            self.describeView.text = [self.describeView.text stringByAppendingFormat:@"\n%d,%@,%D,%.2lf",employee,name,age,salary];
        }
    }
    //关闭
    [self.database close];
}

//清除
-(void)clearData
{
    NSLog(@"清除数据");
    if ([self.database open])
    {
        BOOL isSuccess = [self.database executeUpdate:@"delete from employee"];
        if (!isSuccess)
        {
            NSLog(@"清除数据失败%@",[self.database lastError]);
        }
    }
    [self.database close];
}



-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}




@end
