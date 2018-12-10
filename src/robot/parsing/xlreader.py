import xlrd


class XlReader(object):

    __table_alises = {"s" : "settings", "v" : "variables", "k" : "keywords", "t" : "test cases"}

    def read(self, xlfile, populator):
        # encoding_override parameter's value should be specified in cli or in a configuration file
        work_book = xlrd.open_workbook(file_contents=xlfile.read(), encoding_override="cp1251", ragged_rows=True)
        for sheet_name in work_book.sheet_names():
            cur_sheet = work_book.sheet_by_name(sheet_name)
            if cur_sheet.visibility == 0:
                aliased_table_name = sheet_name.split('.')[0].lower()
                final_table_name = self.__table_alises[aliased_table_name] if self.__table_alises.has_key(aliased_table_name) else aliased_table_name
                if populator.start_table([final_table_name]):
                    buffered_rows = []
                    rows = cur_sheet.get_rows();
                    rows.next()
                    for cur_row in rows:
                        if len(buffered_rows) == 0:
                            buffered_rows.extend([unicode(cur_row[i].value) for i in range(0, len(cur_row))])
                        else:
                            for cur_cell in cur_row:
                                identation = True
                                cur_cell_value = unicode(cur_cell.value)
                                if identation and cur_cell_value != "":
                                    identation = False
                                    buffered_rows.append(cur_cell_value)
                        if buffered_rows[len(buffered_rows) - 1] == "\\":
                            del buffered_rows[len(buffered_rows) - 1]
                        else:
                            populator.add(buffered_rows)
                            buffered_rows = []
                    if len(buffered_rows) > 0:
                        print "[WARINING] Line continuation symbol '\\' is on the last line of '%s' sheet." % aliased_table_name
                        populator.add(buffered_rows)
        return populator.eof()