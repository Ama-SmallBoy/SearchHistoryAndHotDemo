//
//  PublicConfig.h
//  TestImageIosDemo
//
//  Created by  星梦 on 2020/12/7.
//

#ifndef PublicConfig_h
#define PublicConfig_h

///不含有bundle 文件的情况使用这种方式调用
#define Bundle_With_Framework(name) [NSBundle bundleWithURL:[[NSBundle mainBundle] URLForResource:name withExtension:@"framework"]]
#define Framework_Bundle Bundle_With_Framework(@"SearchHistory")
#define ImageNamed(name) Framework_Bundle ? [UIImage imageWithContentsOfFile:[[Framework_Bundle resourcePath] stringByAppendingString:[NSString stringWithFormat:@"/%@", name]]] : [UIImage imageNamed:name]


///含有bundle 文件的情况使用这种方式调用
#define Bundle_IN_Framework [NSBundle bundleWithPath:[[NSBundle bundleForClass:[self class]].resourcePath stringByAppendingPathComponent:@"SearchHistoryBundle.bundle"]]

//【图片】
#define Bundle_ImageNamed(name) Bundle_IN_Framework ? [UIImage imageWithContentsOfFile:[[Bundle_IN_Framework resourcePath] stringByAppendingString:[NSString stringWithFormat:@"/%@", name]]] : [UIImage imageNamed:name]

//【Storyboard】
#define StoryBoard_Name(storyboard_name) [UIStoryboard storyboardWithName:storyboard_name bundle: Bundle_IN_Framework];

//【xib】
#define Nib_Name(nibName) [UINib nibWithNibName:nibName bundle:Bundle_IN_Framework]




#endif /* PublicConfig_h */
