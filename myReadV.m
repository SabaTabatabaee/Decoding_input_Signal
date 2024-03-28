function [v_test] = myReadV(number, path)
    if number == 0 || number == 1
    v_test = importdata(path);
    for i = 1: length(v_test.rowheaders)
        temp = v_test.rowheaders(i);
        str = temp{1};
        str = str(1: end-1);
        realpart(i) = str2num(str);
    end
    realpart = realpart';
    v_test = transpose(realpart + 1i * v_test.data);
    else
        v_test = importdata(path);
        v_test = transpose(v_test(:, 1) + 1i * v_test(:, 2));
    end
end

