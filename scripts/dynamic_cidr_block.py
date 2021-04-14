#!/bin/python

class cidr_block:
    def cidr_num(self):
        cidr_num=[]
        with open("/tmp/cidr_file.txt") as file_in:
            for line in file_in:
                if line:
                    cidr=int(line.strip('\n').split('.')[2])
                    if cidr not in cidr_num:
                        cidr_num.append(cidr)
        return cidr_num

    def find_missing(self):
        cidr_empty_list=[]
        if self.cidr_num():
            cidr_sort=sorted(self.cidr_num())
            return [num for num in range(cidr_sort[0], cidr_sort[-1]+1) if num not in cidr_sort]
        return cidr_empty_list

    def get_cidr_block(self):
        missing_cidr=self.find_missing()
        if not missing_cidr:
            return len(self.cidr_num())
        else:
            return int(missing_cidr[0])

cidr_block_obj=cidr_block()
get_cidr_block=cidr_block_obj.get_cidr_block()
print(get_cidr_block)
